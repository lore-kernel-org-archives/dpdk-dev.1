Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1C9C53200
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 09:46:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C89E74026D;
	Wed, 29 Jul 2026 11:46:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 98B7A40269
 for <dev@dpdk.org>; Wed, 29 Jul 2026 11:46:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785318396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mU3VJsmxpAsdW0hFPUMe+wVtTK96zp598IGt0BkGSvE=;
 b=NfHRLCiIi4hknBsji0Yk3C3m7Vt23kFz34SGUY0APgqAp06sfbFc3JchsXNmbIgu0fYzwB
 le2cp+Jhh3GYvFbGngm+hvowYQU9NFwZXzuHleuHdIe2CcsLqgpkAXIZFi5NzObRCl/gWR
 /6EMdxvLai6a1++13Kq4Kr/MX7SXplE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-syB_VI-dMUSwzA2I7lui7A-1; Wed, 29 Jul 2026 05:46:34 -0400
X-MC-Unique: syB_VI-dMUSwzA2I7lui7A-1
X-Mimecast-MFC-AGG-ID: syB_VI-dMUSwzA2I7lui7A_1785318393
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b2a9f6b0b2so421825e87.2
 for <dev@dpdk.org>; Wed, 29 Jul 2026 02:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785318392; x=1785923192;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mU3VJsmxpAsdW0hFPUMe+wVtTK96zp598IGt0BkGSvE=;
 b=PzBKFVFb+dX17ZBWhKtqPAZ/8zzAaMXvE1EOV6uau0PSAoeCBl2P6XQgasQbbBudNH
 OPJCm63T/fAvj95i95RMDDGmefZzcYWXXyrZ1oozDQCFpaFennBnMN4Js9SRNqYLsDht
 lnRylzOck2VP9cfhtK8AlqAtrbnnl+X2WMmI5doP/7K6r1S7Wo2JJIxAPoSeObo+HfOB
 c53cEYh2YvIgUbFdyTUwOappT4+FgITRfWt5H+PU0U8gE/c1cVQorZXab8n7MKbxJgEb
 lZ+o2hAVx9l/KEGGjBln1K2yhkzNuk2g0YLTo37fH6CfKc2KDHrkmC5owm6XkaaIF9Ch
 2F5w==
X-Gm-Message-State: AOJu0YwUz1xTcA0SXisEN9ngeXB1eoHiY2ZhpiA1jThHvKIGDep2AulR
 sn5VFJJMQp1RosTKqhCxWT328lQdI09Hfp/hi9BNaDA3dOI+RgtHAmz7Gd7amwr3rrtJiFO4osc
 F5WtfqHo210tKmOAgoSp/qkLNYMpX3H55l0f4wBQY6SzY3cB6VGfP144w4GF2OwxLSdBexp+i1M
 szsZLG08LfXd634o89gck=
X-Gm-Gg: AR+sD13sR077KUw+FwJkZUV4TpecMrRTJXHiNNuRXL7TLeKCLAwIdfa1xX01R1ibsPv
 kI2reY3lR6Ogn1/nRRmfel5clnx3cy3x9k8BG2BhLYGJl0zPSY8OalIXX8au54L32aRqr7GYa9Q
 l+XJDbragnOs1t4IJiZHv6b4FiMM+ncm8diYY8eMKMLIGqtaCBGNNqCjriDTJ5BLrr4GeLxFddn
 kZhTkuJze990PyaW8RSoKXw8n4bdMEUdWti/82gqqnBjhSN
X-Received: by 2002:a05:6512:2386:b0:5ae:a702:6528 with SMTP id
 2adb3069b0e04-5b2d021cadfmr1102918e87.26.1785318392357; 
 Wed, 29 Jul 2026 02:46:32 -0700 (PDT)
X-Received: by 2002:a05:6512:2386:b0:5ae:a702:6528 with SMTP id
 2adb3069b0e04-5b2d021cadfmr1102911e87.26.1785318391882; Wed, 29 Jul 2026
 02:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260724164520.192203-1-stephen@networkplumber.org>
 <20260728163713.364168-1-stephen@networkplumber.org>
In-Reply-To: <20260728163713.364168-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 29 Jul 2026 11:46:18 +0200
X-Gm-Features: AUfX_mzLO7OPVPt6o-VZiYzK6qvMaw6jQ9oGVD1jNdUs0LtF0MDmOIPRZBwJ1Ug
Message-ID: <CAJFAV8ww9-q_QGuYaVhT4dMbYJ7fS_yTbqr05s4CzRrpUvt8Uw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] remove deprecated packet framework
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JOrCYIP90xpO5pxh-K8yYPKqwgiZnmO1BsJvpRg0T3w_1785318393
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On Tue, 28 Jul 2026 at 18:37, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The packet framework was marked as deprecated in 24.11.
> This patch series completes the removal of the libraries, documentation,
> and tests.
>
> Stephen Hemminger (7):
>   app/test: remove packet framework tests
>   app/test-pipeline: remove application
>   examples/ip_pipeline: remove example
>   pipeline: remove legacy API
>   table: remove legacy API
>   port: remove legacy API
>   doc: remove packet framework images

So it seems we have a bug in patchwork wrt binary content in patches.

Please send the series without the last patch, so that the CI can do a pass.


-- 
David Marchand

