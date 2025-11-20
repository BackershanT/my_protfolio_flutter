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
            'The team collaboration with Backershan was seamless. They demonstrated deep knowledge of both Flutter and React, delivering cross-platform solutions that perfectly matched our vision. Highly recommend for any frontend development needs.',
        avatarUrl: '',
      ),
      Testimonial(
        id: '4',
        name: 'Yasin',
        role: 'CEO',
        company: 'Yachii',
        content:
            'The team collaboration with Backershan was seamless. They demonstrated deep knowledge of both Flutter and React, delivering cross-platform solutions that perfectly matched our vision. Highly recommend for any frontend development needs.',
        avatarUrl: '',
      ),
    ];
  }
}
