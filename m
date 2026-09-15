Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECD2C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 15:34:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C00A240B91;
	Tue, 15 Sep 2026 17:34:41 +0200 (CEST)
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by mails.dpdk.org (Postfix) with ESMTP id 4BFD940A6B
 for <dev@dpdk.org>; Tue, 15 Sep 2026 17:34:40 +0200 (CEST)
Received: by mail-yx2-f12.google.com with SMTP id
 00721157ae682-85d43da99e9so28680077b3.0
 for <dev@dpdk.org>; Tue, 15 Sep 2026 08:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789486479; cv=none;
 d=google.com; s=arc-20260327;
 b=N1XtXtOdcMhO0Gjb0RoEnTvgiP8Dk7+vK0cuekt5ilS1Hu2kWZ0nuI388N9zuwKXec
 GC6NKIraSNUZUyN8969h7rtKLkp+jNpDkJbNdmtgIIZMOWkAupW/dlKYRt9FJCwuEnq7
 PZpaTAC7jbYHErp2UHZZ3xN3dLonJ0HWso+y9NQJQf9b9vYuwslM+JTo3xwO0y19itEh
 cC5R6LRhPoID5UhEK2KWLEtqG7QZ3q9xQSTcCLnV905jEWbzHAV3cemqUGqdMpiY4oME
 2R/0yFRno7uz8dZhyIHecOpb8EL1bOdoGp7ba4QqDNiWLNPQ661I+qq5s4b09BMShjR2
 lW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=s3GDRzgY0Sp9rW4d2VAkgC1qSAmwDw/bmAHwC+CPg+o=;
 fh=fVV6Y3ovhth2CPsoZ3URcHMu4gGZsiMSEI0u3fmsyQE=;
 b=mQZqIdahTS8GH7ovuMVnbrlOSSP1vObxabbXnbM1BK30I3J9ixXtgjVzhB8PlNqNRH
 4Ro+fC/NNShZNuisBwZdvu/BroKNQ25Z2ELaQKPKG4fEpp4JbAD4mCFQmLHNqQ/vp6vp
 DUodxrnjZEfrXt+HxUckaHYy5bVs3HR4Ro1vPeZP3zokSWI+HykO/7hWl1upZn06FrYc
 13jZAYCk7uHWSG48L9ik95nwy9MzMxwltObFgy1hUt5EMPBTrAyp//GXscBZmjV52SW4
 9fBtetY+FbrmIy9/VV1r1uhNH0CIoaZDGNYqAO8I5uv6uYppwGxSM60g5SMSfD3z/O9n
 VkIQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789486479; x=1790091279; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s3GDRzgY0Sp9rW4d2VAkgC1qSAmwDw/bmAHwC+CPg+o=;
 b=W+O34fTpOSc3K4KXw1udOaRZlz3KyzWWTQSCs1K4Jgd49JQOG972Hre54ezxyjuPDi
 Ee9K6ale2y+5uhUUkShGGrDbatVh7j5nxI/14Epl/9eS02EZLbTX3hJHH0Lq8ajU1IPU
 L3G4rIENkXPwUY0xnZyhYb8kIGWYwuereTCE9G+IeXF/fqzlZ+tTNZTsI1gfag+X9LqZ
 maKI4oNlQHmIu2rT7odMLP1Tp2TzwulsVswXMRGkOgSvbhvF+kUxkvrdPfG2lKwLmyer
 PLabugsGsWaqj2gWfwxNHJ6rP1lBPVNU+RfcMhJqnsrb3T7tizfZT5YpjqvqRm+V6NVU
 SmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789486479; x=1790091279;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s3GDRzgY0Sp9rW4d2VAkgC1qSAmwDw/bmAHwC+CPg+o=;
 b=h5Y3VK5ls/ZLgbd/VtKH2Sq299/gmb4kxjgYOEl4lABiXieS6ElcOTZYsS/pHQCbKV
 jvlGiH9H/CtRTd3jA5pcH9oU4R5clCk83wudLKTtWsB7zuEossEG6+A15Umll/RtYvLm
 I9jx2YHQY3NG1mz4XjtLR1Ds9It4kcihRIxEwzBu0b5Ht2DNPQl2jw1gxLgzYLBaAJMs
 DB3GwsgE9wn9eA+kme5n780x0OnhRAugJC4OSLKSI94eLXsyMOUDDnl20U/HdeHsxxY1
 MYjFSjqfe3pafsMuI1avbcFZPk+RMpSYkd8ek/PX9eCGjtjlmaXAHZjnOYbj5Fg1DSsY
 cx2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZWApNTKjkvWGx0bOvOYBGiK7w+nKWz3m7dzSef7ODWVHaKwAUp9DVS/iMV5+TC2yMKNI=@dpdk.org
X-Gm-Message-State: AFuF++lsPMIKCx6jfqlcY+YdXQrwPBnhqJGj+JMbWd0hUNfFB5e/CUDJ
 Ah2X5Q/9iKg7VdM1Dtyk3zckCfNgi8zk7UWLCXevhIO/QMJ8lVJ58wl+sFqYeICfrvKUgLJzosO
 eE/5yT0eKV9c828Q9z401DvoAfhRq0/c=
X-Gm-Gg: AYBFou0B27MNNfqILBs3KvX/VQiVkUms4+0hbIxo5qkqF75OZHgEtCrgza/q9KxYwBf
 HaKZqh7p3fQPt6Sw8WvEc9zkgepOnKFKHhbcufUV2XzMveKGs3eJRTPY6cu2KKB+3fYLL+Hx/9x
 629S0ciovF+R+T0nF0bVRvNoHDzUkA+cer0iayrF+9CMYBiBfSMYEm/trVBQA0BMzDXAdpB3Uvz
 w5eY41dymX+jyKJSoVwUgNU+Z/52pOBBQ8jZsMyjZl+g/WA7idZbS3tENcilB66Vb0IO//8WENF
 bYod8Vu9vPMD2eeY1A3SCkcIJhClYufO9XlYozeIP2DHutZk5loVXeQJVTjL6BQu66Xg8g3ExDA
 ZNuuGqx1dYKkDUMO7cF1K0uWiKDWjoPdIghL/xG0WnsCyxI/DcCuUMkUmy8V2yHSjjsdS1qUjSm
 W85IG4KcSjfV+5afz2
X-Received: by 2002:a05:690e:450c:20b0:66f:c47b:f588 with SMTP id
 956f58d0204a3-6714e088884mr1812014d50.57.1789486479296; Tue, 15 Sep 2026
 08:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260910135649.24956-1-pbhagavatula@marvell.com>
 <20260910135649.24956-2-pbhagavatula@marvell.com>
In-Reply-To: <20260910135649.24956-2-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 15 Sep 2026 21:04:13 +0530
X-Gm-Features: AcwNN1UKdbNtkvxmcvmFPSzvXw61G0ALa7N6pCc_eX0bFECqBgqsyMYgP5x2Sog
Message-ID: <CALBAE1NV5jf5HVtE5GSPyvtw9f9=YOmLepcDoUZ9zUwdvqNTWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] event/cnxk: advertise CN20K preschedule capabilities
To: pbhagavatula@marvell.com
Cc: jerinj@marvell.com, Shijith Thotton <sthotton@marvell.com>, dev@dpdk.org,
 stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 10, 2026 at 7:27=E2=80=AFPM <pbhagavatula@marvell.com> wrote:
>
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
> The CN20K preschedule callbacks were wired up but the capability
> flags were never reported, so applications could not use the feature.
> Advertise the preschedule caps in cn20k_sso_info_get().
>
> Fixes: 1e2d9b3dfc9a ("event/cnxk: add CN20K event port preschedule")
> Cc: stable@dpdk.org
>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>


Series applied to dpdk-next-net-eventdev/for-main. Thanks

> ---
>  drivers/event/cnxk/cn20k_eventdev.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/event/cnxk/cn20k_eventdev.c b/drivers/event/cnxk/cn2=
0k_eventdev.c
> index 9d34168c3292..29495eb4f9f4 100644
> --- a/drivers/event/cnxk/cn20k_eventdev.c
> +++ b/drivers/event/cnxk/cn20k_eventdev.c
> @@ -431,6 +431,9 @@ cn20k_sso_info_get(struct rte_eventdev *event_dev, st=
ruct rte_event_dev_info *de
>         dev_info->driver_name =3D RTE_STR(EVENTDEV_NAME_CN20K_PMD);
>         cnxk_sso_info_get(dev, dev_info);
>         dev_info->max_event_port_enqueue_depth =3D UINT32_MAX;
> +       dev_info->event_dev_cap |=3D RTE_EVENT_DEV_CAP_EVENT_PRESCHEDULE =
|
> +                                  RTE_EVENT_DEV_CAP_EVENT_PRESCHEDULE_AD=
APTIVE |
> +                                  RTE_EVENT_DEV_CAP_PER_PORT_PRESCHEDULE=
;
>  }
>
>  static int
> --
> 2.50.1 (Apple Git-155)
>
