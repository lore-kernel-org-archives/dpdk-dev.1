Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E3ACD3445
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 01:44:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7223402C6;
	Thu, 13 Nov 2025 02:44:26 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 6E83E40151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 02:44:25 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-297e264528aso2451925ad.2
 for <dev@dpdk.org>; Wed, 12 Nov 2025 17:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762998264; x=1763603064; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n3q/UMlS+lRGnM/eMWoEpeHmJ/coV2eUAD618e4iG5s=;
 b=cUeg/26dUiNPM98D0ZVguL1OzF8rAWbs8NNCkpdjjSfXBcGAAz4eKWqUgqqJ1iBHP5
 8yiP2j2spLFUmchB42TneA9REUDCeLVEVeo+chiQkUb6m4n4szIRcJ2QbcUC67z/EDB2
 fSsRVZDxUUsQ0lpczKcEW3wrK2wnzRE1emM70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762998264; x=1763603064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n3q/UMlS+lRGnM/eMWoEpeHmJ/coV2eUAD618e4iG5s=;
 b=hXkn3dZE9WRW8Lq5eyXHMMQNe3acf2h6qlCo5HYjIxbzt5JNGiDKak5JsdrIn5+6tZ
 1avt+txREjA2itoIOEehHb9PvEW3zPnHgi4yZI2TwGai3/rCJrDuJ+bBaX1CpS83GRjH
 p+mZf38eMDB4VEyj5HlTSJ94+8eqv1hEg3zhmhWueHifxKsk55B7mfVb2Swnt4jvL/b2
 uzZAvdv7MmXmOljCFiVwi6OaQell5j659BixFVPD6O9/McSxh1uFoMQv5GYGRivpllvt
 2gwYGtw59ffXqNNRnNByXcDcA2ePYGUojndy7gd/gOaxM0qiwNhCFcpd0gsmIPhKajvw
 3fQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKKCW0wfjNolzd2QOwcsihUZRhWzTEpl19FCih1rEtE2bC39HFCTONNUOjt/87mE9E8D8=@dpdk.org
X-Gm-Message-State: AOJu0YzLqyaYHhYB0tAh2YyxUPyl2nfs2TnbGQYGZEy1KXJcbamrOiVQ
 Ajgk2aRcoe0CYIRgvfgceTLf4t7Tdkv4hnV1n90kcdvyKtL3I+GiSZBUuSnWgXHlv5MiBrV9uqM
 c3fuvZgYI85PDpaApxPOGN6dS0+aw2SSMLtFXB3QlMw==
X-Gm-Gg: ASbGncsbB3WGvjIhS1CI5n714eTvG9ji50XweZJE7gx1VKeFp5sBboLsBrWKWvGuu9x
 LuwoZri5BXUkJ4uWMmB4rhHC8UrnHBNpyxOCrX91r7JaP/wck2kFzne8tOcSHu+s/XlVAJQ9T+1
 aKHDtujPWakq432bgOlEKxYUkcLqzdop7PKoF+SPIpWirab7IhsOc8/rfga21zeoZcSr5dBvfld
 xqqt9DsFFn7inAQXjJ/t9GBuu9wdZhDw1zdu022uFef5wLZStCoIMOHPMvMGAKcZIKInrRrK1c7
 fsM+5iwxZQ==
X-Google-Smtp-Source: AGHT+IGZVOogBmhVhpeJfqpfH8Kp1FDN4wxc89eHLTP6crox9/ypiuBdHG4cG9BgW8bZ6z9ps96nBU7Pb6T3zX2zhdg=
X-Received: by 2002:a17:903:b06:b0:298:45b1:89a1 with SMTP id
 d9443c01a7336-2984ed3007bmr73682735ad.12.1762998264462; Wed, 12 Nov 2025
 17:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20251024185056.607160-3-dmarx@iol.unh.edu>
 <20251107215020.255182-1-dmarx@iol.unh.edu>
 <20251107215020.255182-4-dmarx@iol.unh.edu>
In-Reply-To: <20251107215020.255182-4-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 12 Nov 2025 20:43:10 -0500
X-Gm-Features: AWmQ_bk0SPDY0aauFEaM5JpdG9pdgSjAxnPuOGC8ybdW35yeA3LBFjHuWdXJNSs
Message-ID: <CAJvnSUC8+uKi9uK9WxwX86mYARqy4irD3tAZQYaFU8dnRfMQ4Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] dts: add virtio forwarding test suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000004b11160643700585"
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

--0000000000004b11160643700585
Content-Type: text/plain; charset="UTF-8"

Noting that the dts-check-format failure from CI is now resolved and I have
run dts-check-format locally on this series and it is passing.

--0000000000004b11160643700585
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Noting that the dts-check-format failure from CI is now resolved and I have run dts-check-format locally on this series and it is passing.</div>

--0000000000004b11160643700585--
