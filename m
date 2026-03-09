Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF01BF41807
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 16:19:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1362402BE;
	Mon,  9 Mar 2026 17:19:22 +0100 (CET)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id CF21B40261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 17:19:21 +0100 (CET)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1271195d2a7so7574041c88.0
 for <dev@dpdk.org>; Mon, 09 Mar 2026 09:19:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773073161; cv=none;
 d=google.com; s=arc-20240605;
 b=j/+hTE0r/2NAoPfloFmkzpXVMSyAiy2J/XR7mi1DpM5QNI+4nM3h3ImUx4vBkGtNil
 XqKu0QofeZHgH7uQ0zCLsQFZ6mm94ruvk6X60cDPsEG8Kj6BXdl6vHOYoRGfJ/uz2C3D
 lTLADwEaf0gxmKIF0DhRiK+kvvUmRGKQBK1k8CH6SoZ6B6IZaFvaTsKVWiuJGItOGslM
 Y5aI2ROc1orjmF9j6PJcVlUrD5sTu9fguRwvUFEFda1io/OrX/rWXA+JESMCzwznrSsU
 CpPtIF33PT4CLABTIl+eQO3vdNH5Oqy3NVy1h6F+bMGqn19JUTH/NJ7eSI5ANbv1CRXB
 tKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vw/tFDHH6tkHYG1KT4Yz8h3xeGDEdLvwRhR6BDP7lCo=;
 fh=tdFIS2wXfwPa7g55pm/jbYnj3BHrVEI4ImHIcekhxAc=;
 b=Q3kAWL2k4R1Zbuc4Ihvc0DFpj0x18TzAAUV/8VSHlf6E7BoR1tgGZxdz7btc73BMEA
 87pR+tnSJlHBlHeJJ6+2RNJOGAhRrmjWcU+KqwPk+al7Wq5ETExv9Jii90kELHyNX3jU
 ahRsUsQjBo3VPwKzr2vgYxMp1G88ej59Si0Ie5KaB1HxraXGINBb+FLt4otUmvduFEbK
 R3WeZma/WJyErIY5Hsfn+RQeYGIT9+rSU4IbaFQRzG7EKIvvrW/0qUnHI615HmJCp9+b
 qn12kkkLpdFY6KYNXuTAmOddok20rkFcblVynYB6VMKFf+s0WaUgZE/Tgk+yVCYhmzLP
 gFfg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773073161; x=1773677961; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vw/tFDHH6tkHYG1KT4Yz8h3xeGDEdLvwRhR6BDP7lCo=;
 b=g1qHi3k/xc6f+wkYCBAqbEXVhwfTDyOT393HFSxdSDn32VHf3RVpE2gy+9T4jDGqFf
 /er+2sTmc6KKNQE7dndzFBF3uUpzCO+ERU+YgAK7R7nuFCFRue/a1mfVLF9I7SkZ/Eur
 L2Ue3y/1xi7ZC+0JbJbZveV8+mM5Bes0BxsVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773073161; x=1773677961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vw/tFDHH6tkHYG1KT4Yz8h3xeGDEdLvwRhR6BDP7lCo=;
 b=KcgNXQWgjBGj//L1a34454srLooIPyfm7bCE7dtYtBxmyir2qS22Yk4fchPHTJNv4h
 K6cjx8NFArCtlYeLxeS0iZhodzlxDwGfnjAQ9iApfs60pcVj9sJN18OuT7WF9Dj+4bIV
 as0+c1tk/pVQ6SdHVaNxUpyiViWKvpa0W5avyhr1VDl9s5qSay9IJq1L1SeVtBuk6wk8
 v8TCQRBIDhkpybIIq3Q0QxXGOA41MUv4ouI/s6CJsUw7C3xkrfgVErn02qHjtKmhrupR
 SROvdT1H6gkTabfzVwHsRE8DW8TqBEYrPbmN4aVmxwQF6Zqn96i+3Q3qIi3NJa7w+PDr
 SKVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkipi7dudUt16YAReKihoaVOfL3XY5hfAdxgFSJeq6YAb0rdk/ZW6J4uhDFL7+2s4DF/w=@dpdk.org
X-Gm-Message-State: AOJu0YzqX2H2ZJBXFaLUrU1+DtVqdHVzS2C71/CoTvBtZxZ5iTGLKe3q
 FarxaSDdAKYRMKIHEBNcJqIpJ9NVesCKPTD9XDUWBTdgCbT1JKyOBYNL8v8otcKfRKqi8e51lyr
 29BT5jkCXB/aOsP5ZrgPFHTdVTw+N9ujJBf2Tybz4PQ==
X-Gm-Gg: ATEYQzx86OOSImHuZ8yvnm8FYirdt8f/y0we6cK05IabuFu4zkb70nAQwokT0qZXEZZ
 KxdyxX6H5gaKoSxBytIBjBcJbYs7Rix9HnsrAQUBx0jARn1Yo2OnGGh3sroOr+NGBVPZid7zXDT
 f00500qww2qfVj2q5D84YU7sDMK2FAPTOI8z32KvRW2i9iYAbLllDlXfeLG4iqTOi77oG/9FDu8
 GOrpHgYIPfjv2MVeh92HT0iihrhCPJBdxKkgG1npnq7xWf2uu6brk0EdTwAeoUl7cfuHvQfS2qq
 NdWuw/iZ3aDNVG5F/38CWlKYQA+YYCqMExggyrBjH3WQv0goEUILjcU=
X-Received: by 2002:a05:7022:211:b0:11b:9386:a3be with SMTP id
 a92af1059eb24-128c2ebd33bmr5127912c88.41.1773073160618; Mon, 09 Mar 2026
 09:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260220192510.37163-1-abailey@iol.unh.edu>
 <20260224163200.39360-1-abailey@iol.unh.edu>
In-Reply-To: <20260224163200.39360-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 9 Mar 2026 12:16:19 -0400
X-Gm-Features: AaiRm53bw05-NOhaRtHBml8kCdsSDsGV7xTyjThiEFpMM5ZzkLIyjDAbaRqC-7M
Message-ID: <CAJvnSUCXZhntBmPJYpXobBpCwkBmRWhMPZhH9Sm0W9GiQD_ZVQ@mail.gmail.com>
Subject: Re: [PATCH v2] dts: add support for no link topology
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu
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

Recheck-request: iol-unit-arm64-testing
