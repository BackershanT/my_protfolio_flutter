import 'package:my_protfolio/features/shared/core/constants/app_assets.dart';

import 'testimonial_model.dart';

class TestimonialData {
  static List<Testimonial> getAllTestimonials() {
    return [
      Testimonial(
        id: '1',
        name: 'Sayyid Salman',
        role: 'Founder',
        company: 'Alison Tech Lab',
        content:
            'Working with Backershan was an absolute pleasure. Their attention to detail and ability to translate our requirements into a beautiful, functional interface exceeded our expectations. The project was delivered on time and within budget.',
        avatarUrl: AppAssets.testSalma,
      ),

      Testimonial(
        id: '2',
        name: 'Dipesh E P',
        role: 'Product Manager',
        company: 'Clan LEO Pvt Ltd',
        content:
            'Backershan transformed our digital presence with their Flutter expertise. The mobile application they developed for us has received outstanding feedback from our users. Their technical skills combined with creative problem-solving are impressive.',
        avatarUrl: AppAssets.testDipesh,
      ),

      Testimonial(
        id: '3',
        name: 'Biby Chacko',
        role: 'Senior Developer',
        company: 'Techmindz Pvt Ltd',
        content:
            'Backershan is a rare talent who masters both mobile and web development. Their code quality is exceptional, and they have an eye for performance optimization. Working alongside them elevated our entire team\'s standards.',
        avatarUrl: '',
      ),

      Testimonial(
        id: '4',
        name: 'Yasin',
        role: 'CEO',
        company: 'Yachii',
        content:
            'Professional, reliable, and incredibly skilled. Backershan delivered our React-based company website with pixel-perfect design implementation. Their communication throughout the project was excellent, and they offered valuable suggestions that improved the final product.',
        avatarUrl: '',
      ),
    ];
  }
}
