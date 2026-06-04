Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CB7CD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:46:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0CDD4066E;
	Thu,  4 Jun 2026 18:46:50 +0200 (CEST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 825C74066E
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:46:49 +0200 (CEST)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-68c1653ea0cso1321266a12.2
 for <dev@dpdk.org>; Thu, 04 Jun 2026 09:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780591609; cv=none;
 d=google.com; s=arc-20240605;
 b=IflonAJTBWvG7ve76UhqdKhwO9tCdPL718neUaB3e99hlXbXVeDD+mhSklZNMddGca
 dwdOrUOzTRFZhg+jr430+fMgr0iZk6IvOlLcflckd/Gg/Ehr074bmvDyDsTwGIXnkAnJ
 R0Y1QYA1Idag0IwhqbYp0V/P4xt80TNH3hRACJeHkoF3bzAzXpwRvmbvCD6BLeX+nRN0
 AiqZXATOxZCRqAS6Cxc/Xh8FQLDNUphRKlq6KfN3oUI6HRtLpXGfWPDeDz/FOgoFEAvX
 3D/wHI0R0BIcqSRGubsg0w52TFpzB6RWXcTWcS7aNWju1TKX7mZpwQQOdoSJHjCoGQia
 cPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jaf7PkHXNf1UBi1usLxUGOZJ8HR8p5PGcbvy+mxxfPw=;
 fh=+uWMC+9Oumodyyi6JPxaifyBvJfbdDrb+E77o2F8lzM=;
 b=J02Rtf441/jRgy/bW9yjYROJxYaf54M282bpn5/ZO0tKubhL013nvm70GxN+0PYZf+
 n5zbe73inXCY4vl5pVhNRFPT/gf7zUzpXvlFBzhlllUnxpRSNourNLnP0t0MA4AmSU25
 tuRNeRCVRVLn7PdswSZSbkM5Ko7RTIeBi6ABvvTPq2M24FHd5jamXCSvew71t8FomTbn
 uzwm6EAJbJ9cwJeY0h8EZEvyoRgfIfHCbq36BitcHFHDvNpiktlA0lJOPrJSFm7NkGwN
 W1F0fXwE/qNI34GaMWPnt/98QYBKlhZos670VMxFdyf+4FetYFeaolTUVj7QHvykhDAk
 WDGA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1780591609; x=1781196409; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jaf7PkHXNf1UBi1usLxUGOZJ8HR8p5PGcbvy+mxxfPw=;
 b=MioKVNwrf0cwL5kX/bkh+6M4ZBn98z4Q81Lt9lcZetvYRZHlkXEBx9PxkQdReWkQGP
 UW9JJxpQ/uwlXtX7Zw4rpVf7qGdAVfVHDuMTyx5OK8nNAr+U849aVXfOg0FQTG1qLGWv
 XeHcy9XZdrZmZ1ibyk51iMWQqyv3bLZRwPNRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780591609; x=1781196409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaf7PkHXNf1UBi1usLxUGOZJ8HR8p5PGcbvy+mxxfPw=;
 b=fRrjLgj5eXn7Sb5ACbKeGWb+RbgMMSrhUZHTwVTEVbHvjvI4cRHZR14zo32eiUggI4
 kJCuHSKLoOkPBItSWnw7LTrMu0fOjk+5PvLTfnzJbs/bq9/+fTcxgJRHxJh5IjYpdF6i
 mKnhEdJtVbOMhLPCI6/4BMmkfdbAuWUbiYp2hxg7TnmdWtC42XM44zZ7Y7an9MOnpMec
 2SaLXYuYP7+45BPRcSurHwfWNAZYv7kx+tYWGWpP58zuU+4id8TPauneKurdVhZngIiF
 fn86cQN41Ac4rhL4PL8PduL9CSnBP64yNtjQoCFdQd3/B+iwQDEI0pM6SiSechdegwlX
 qVIg==
X-Gm-Message-State: AOJu0Ywkl98VNu0h0k4V8ULsSZEccdN6RsVO7FRCBGqLpQedLISPJho4
 GbJSEjcL4yswEXqYmFedSw++KQbIpQJYEDyLGmbIlk6luys6hC1ttCUKTnyAQ8YQ5+JbOaoOTwI
 p7h2M7y50FCrc+V//OcJPa2gpFgtmDbFzT/5JHvY3kA==
X-Gm-Gg: Acq92OHeQx6qdNEd9vXu3nhMDxwGlIj187u3eMIw7aoL5vy68DafjtQ4KyyzWejm5Wf
 Md7KbjUUqfWnFmmGLwZ/7gxch0r0RruFBXAaccBXPr/K5z2OmH03rbI7k7z2xG/VsrKsw61j/WA
 f+YHKm2vqHNZ4Ss6D9n5c+WDugE7hnAoHnruvHIHfFux4DwcBByeOihSTCFPt4WUgotx3Z1AVvX
 j+7VQHJXyj/D8klVK9bv3DPYfAiiIpDbHmqndfD2cNLCcK1yVKy1t7qAvXpq+PIHcmG/OT92t6i
 wzIA8RzqephfslFxEo/fVNW2bxe6/vMCcocPp8Ot+w+7Vwu+N1cP
X-Received: by 2002:a05:6402:3216:b0:671:ab62:765b with SMTP id
 4fb4d7f45d1cf-68e7225012dmr4426293a12.20.1780591609056; Thu, 04 Jun 2026
 09:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260515174714.211668-1-abailey@iol.unh.edu>
 <20260518175424.253600-1-abailey@iol.unh.edu>
In-Reply-To: <20260518175424.253600-1-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 4 Jun 2026 12:46:37 -0400
X-Gm-Features: AVVi8CdLgshVEfhSU98UavduXKSn6ZP-K51VGzA9Zw2Z2HzLLR8VPLSZpcjdaWw
Message-ID: <CABJ3N2WbZT5pkZZtWe0cp4Lbks0EtGaSra=N5=-S4ZtsF9QDHA@mail.gmail.com>
Subject: Re: [PATCH v2] dts: add retry loop to trex traffic generation
To: luca.vizzarro@arm.com, Patrick Robb <patrickrobb1997@gmail.com>
Cc: dev@dpdk.org, lylavoie@iol.unh.edu, knimoji@iol.unh.edu, 
 ahassick@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000005924f20653704ad2"
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

--0000000000005924f20653704ad2
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-unit-arm64-testing

--0000000000005924f20653704ad2
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Recheck-request: iol-unit-arm64-testing</div>

--0000000000005924f20653704ad2--
