Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D90C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 14:42:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F70742E80;
	Fri,  7 Feb 2025 15:42:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2161842DDC
 for <dev@dpdk.org>; Fri,  7 Feb 2025 15:42:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738939340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K8xlu+uy1z+McKp6uzZRdS6DM/jUN5gB0hyB54gey+c=;
 b=ANbfKFrQs0QNg1e5Fhyfmm7IGX4tj9m9glwnTOVCuQf5kZl8SqoHrPxMiyKmiMFPIf5TLe
 VGl9gBlSYzeGABGt3xQ5UXZm2l450woDlo0HvSuBZN0cO53Kz1eJZlUO5prqfP8EAqrw8m
 0bAxRNkit1DLXLynnrRQhjVwoYWF7B8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-LCawxz_vMG-o7t5XY6DrCw-1; Fri, 07 Feb 2025 09:42:19 -0500
X-MC-Unique: LCawxz_vMG-o7t5XY6DrCw-1
X-Mimecast-MFC-AGG-ID: LCawxz_vMG-o7t5XY6DrCw
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3022598e2b4so10584521fa.1
 for <dev@dpdk.org>; Fri, 07 Feb 2025 06:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738939338; x=1739544138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K8xlu+uy1z+McKp6uzZRdS6DM/jUN5gB0hyB54gey+c=;
 b=mpHrrZ5mN2AXBztWP842NBYgCtuEUGSp3F1THnKbMZJw8MWm5LSAnZqf6ym8CRFoKI
 gilFgmQBX4vN0XKEnNu9z4JGbuI482OXOl23RzHxX9O1mrYiOj96CXgJRsPMVEptEH6c
 BGHfG56t5SdJxvK8UFXi2cshY103z8D9EOwdvl0Cq7AJGWSLAD5IdEGK2nKVrFInQfPQ
 5LwpmuvpEeGAPpLnmgB273zOAdLGJq9+6RfJOhr8kBbU5aelCL5a3lA3lNjlac37Stjy
 7ycK4fDWNZnUKffqvCxhXbjRuAcIlHwrnS/5ILGOflSesMLGRf+p7xZd0ruWclji66qu
 Exig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDEtcXSkMbhvaq2ovyigPiZDGCtjzg4k5RAm5Kix8Pq+mlO2f0c5AS1ryc7zrHRGEIsWs=@dpdk.org
X-Gm-Message-State: AOJu0Yxl/MdHPX0GatScY9Er9EGBh6clTC55B371XyjBVxVUm/u9GtEe
 s7G0tqKwCFdv0SBWTfzqv5/102ArF+yPTPOw5m+grA1xe2FAHQOzezDuGDEg9DqqgNk79r0AWRc
 KCoaTfzr4hCOvFi1IByHUY8AIXlcmZEHMn0eK46dJm6TedXpJsW6GLGDZ7IcC+nX8BgYrOmK533
 IXZrJEhbL/nPGc9Tk=
X-Gm-Gg: ASbGncs9Tikr2aLQAuZGPpHywDSxZmPgeCr04Db3bfomjx5CUTsrAJbC2JkfsMzvmBM
 R/jejt5jRmdaEv5brtLZMQN7Ihhb2k6uP1XfbKTESz5XK5NTyR6g8O9w61vfLfpW/
X-Received: by 2002:a05:6512:3b81:b0:543:e411:cc49 with SMTP id
 2adb3069b0e04-54414ae5236mr835917e87.38.1738939337625; 
 Fri, 07 Feb 2025 06:42:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwfbPT9+SmMymeSCsCbACLHOH1kfcWwg3VdGXacc0mLNfsmJcUutCMKNrQ3/XFYQjT7hePhNRw4T7X4QfYKp8=
X-Received: by 2002:a05:6512:3b81:b0:543:e411:cc49 with SMTP id
 2adb3069b0e04-54414ae5236mr835906e87.38.1738939337207; Fri, 07 Feb 2025
 06:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20241220142938.1300646-1-piotr.krzewinski@ericsson.com>
In-Reply-To: <20241220142938.1300646-1-piotr.krzewinski@ericsson.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 7 Feb 2025 15:42:05 +0100
X-Gm-Features: AWEUYZnrHJLm3i5h7aT8-FWe__i0Krgs6IzOgp3tE3-QCWuFtS0R5WZi2SqRJ3o
Message-ID: <CAJFAV8x8j10kTF4Lb09CzT=d8=MTwV2jTAQ5w4aNw+yRBXqtwQ@mail.gmail.com>
Subject: Re: [PATCH] service: fix getting service lcore attributes
To: Piotr Krzewinski <piotr.krzewinski@ericsson.com>
Cc: harry.van.haaren@intel.com, dev@dpdk.org, mattias.ronnblom@ericsson.com, 
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FD-SwQ26MvICecRuPsDdqOj83cKCNJYTM-eETQ3ka-E_1738939338
X-Mimecast-Originator: redhat.com
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

On Fri, Dec 20, 2024 at 3:30=E2=80=AFPM Piotr Krzewinski
<piotr.krzewinski@ericsson.com> wrote:
>
> Perf test service_perf_autotest was failing after introduction
> of lcore variables. Fixed getting of idle_ and error_ service
> call statistics.
>
> Fixes: b24bbaedbba2 ("service: keep per-lcore state in lcore variable")
> Cc: stable@dpdk.org
>
> Signed-off-by: Piotr Krzewinski <piotr.krzewinski@ericsson.com>

Applied, thanks for the fix.


--=20
David Marchand

