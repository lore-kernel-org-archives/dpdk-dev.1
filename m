Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702BDC44502
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 09:15:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6DED4026C;
	Wed, 21 Jan 2026 10:15:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4AAA8400D7
 for <dev@dpdk.org>; Wed, 21 Jan 2026 10:15:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768986902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CWUQlElcdV0tPnJ+/myoGhsQpr0z8VKYppRYPwjxoNg=;
 b=XoNSCg7n45gAs1VxXQglox769EFXMIYXo5+GpoW02YXZQh/B1dbWTrJ84YgSBs+u+BqUq+
 A6zO9RiTG0e7OdagZ9DStlFzjdr/A5ZAKmn0hOniYnB4X5U6P3H+m8rpdKH/DZ+BP34ZPT
 F46Af2SETT9bldn5BOzbYDqcdgiGpH4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Cw87OGkYOKWrHs5fn09Utw-1; Wed, 21 Jan 2026 04:15:01 -0500
X-MC-Unique: Cw87OGkYOKWrHs5fn09Utw-1
X-Mimecast-MFC-AGG-ID: Cw87OGkYOKWrHs5fn09Utw_1768986900
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-383005da622so50893661fa.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 01:15:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768986900; x=1769591700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWUQlElcdV0tPnJ+/myoGhsQpr0z8VKYppRYPwjxoNg=;
 b=inJDVpE7j3THpRTXND+ycv31FJRVfRsgK9MJSOw9xwBtSnLBF0rwm4qmeENkgxvNfM
 1nzyu/F/IcQBvEBcM5jhtGuTQ+5DpN4Y1+b+vN3i7FL921BPn8iNtdw6TuK60oVfmDxu
 GApHWxvOxomIjZpM9/ZPekP2W3PGGzSBBMWvP3gzpF0EGj/0xg0QVmQoKc1UXp171HnR
 qiRaAK8xXr0s992bHo2MeH5xU+7UKKgxVC0sEBl549po8C/rZyqYYciwwWwkv9k02laO
 6GLqU9DOs3ojB8IC+ln/ELjU97xaVAvqiHSYLq0ibJSZSxsFlkEFnbOGZAf4yxNDAzuC
 /Nhg==
X-Gm-Message-State: AOJu0YxIno8f4qZ1RRMEeCMjcZDxFMOVEJ9aRhUV8oyEZNJOZirOgw/7
 86CMoU0pnwIcrKqwrLdoLxMpX/FropoGxkUcYMtSujrgn/K7CLmVHy1VxYdjy1IewpYJvZkJ+2W
 azq+VgH5pbWChqOSFkLZe+vxrm/gM118HU+xLGdDYWZ6MAFEag/08yuCb5i1uElpbvGbEqOMmse
 UJUTecoJhQEpuSHXfR6Ig=
X-Gm-Gg: AZuq6aIHmcNWAUrHMyU4TIPcN3Md6ZfwfyQLIjGExAwpwdu7JWs3wU1L8VohP2KY7oP
 QyfNx/r6DB9Z/FpOOTYzlzsCN37MSizxLr59X7o7VTeVROxHXrRRi+ZriuDNmr4pjySJrWrNotd
 qw5VZykiR/vftltENRnG0gEqbfBPIYzuNRGoux7Vx1sM9w7pYAjMaazirQvjaECk8rKS2h
X-Received: by 2002:a05:6512:3406:b0:59b:b2f3:7d46 with SMTP id
 2adb3069b0e04-59bb2f37f02mr5951161e87.27.1768986899660; 
 Wed, 21 Jan 2026 01:14:59 -0800 (PST)
X-Received: by 2002:a05:6512:3406:b0:59b:b2f3:7d46 with SMTP id
 2adb3069b0e04-59bb2f37f02mr5951155e87.27.1768986899244; Wed, 21 Jan 2026
 01:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20260120112552.921243-1-bruce.richardson@intel.com>
In-Reply-To: <20260120112552.921243-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 Jan 2026 10:14:47 +0100
X-Gm-Features: AZwV_QjOweTEMAd6i6i78Q0DhztDp7bYIQ3HguMY6bc4VvrJK4V620tCcUhSBFA
Message-ID: <CAJFAV8waN3mZeSd=KX7C_N-DR_SpnR3afo=UwcOUeZy1+bP5hQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] improve debug output for EAL flags unit tests
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, anatoly.burakov@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XnI5MQ4exfs9RevlS4SUSPkstIk4lM46sSFw46MUyZ4_1768986900
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

On Tue, 20 Jan 2026 at 12:26, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> If issues arise in the EAL flags unit tests they can be trick to debug
> due to the lack of debugging output when running recursive instances of
> the test binary with different EAL flags. Try to improve this situation
> by adding extra debug output for recursive dpdk-test calls in general,
> and to some of the EAL flags tests in particular that are proving
> problematic.
>
> NOTE: there are intermittent failures seen in github actions with the
> file-prefix EAL unit tests. The problems seem less frequent, or possibly
> "gone", with this set applied, but even if it masks the problem, this
> set does give us greater visibility to debug if they do re-occur.
>
> Bruce Richardson (3):
>   app/test: add extra logging for recursive calls
>   test/eal_flags: add line numbers to error messages
>   test/eal_flags: add extra logging for file prefix tests
>
>  app/test/test.c           |  14 +-
>  app/test/test_eal_flags.c | 373 ++++++++++++++++++++++----------------
>  2 files changed, 224 insertions(+), 163 deletions(-)

Series applied, thanks Bruce for looking into this.


-- 
David Marchand

