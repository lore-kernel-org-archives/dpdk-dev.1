Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEE6D1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 14:47:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C56140A67;
	Tue,  9 Dec 2025 15:47:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5C9A24067D
 for <dev@dpdk.org>; Tue,  9 Dec 2025 15:47:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765291627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oL9Dx8OBPIz7ftyyOyS2KrjftE4gGm5Ck4rItFipKGk=;
 b=L8+ykLm3AXIrziB/aJX1CI3dn3xncqVQhIF+gOLREtOAaZwWJ7ZRBGfEqA0mkZw8AnlTyE
 60UISjbe3z4GtGzshzkRv/h/DgwkpigeZGlYvAOYENkZX9h+wqwpfyGLtS3DLp4GFkn45M
 5rP2YwSN9im2IbFFH9COxmEago/R5BY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-1SAFykblNPuccl3M9SUj8g-1; Tue, 09 Dec 2025 09:47:06 -0500
X-MC-Unique: 1SAFykblNPuccl3M9SUj8g-1
X-Mimecast-MFC-AGG-ID: 1SAFykblNPuccl3M9SUj8g_1765291625
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b2c8fb84fso2806553f8f.2
 for <dev@dpdk.org>; Tue, 09 Dec 2025 06:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765291625; x=1765896425;
 h=in-reply-to:references:user-agent:from:cc:subject:to:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oL9Dx8OBPIz7ftyyOyS2KrjftE4gGm5Ck4rItFipKGk=;
 b=P3GExVhLLAe4zxXV2ipAlR38pyJrfEVlp1xC9Fxwxupnzs/RjUzJz5EcLIzumakg46
 BqJF0BwO9iWNjLi7RwUNf5yrIJ1xo+Cm0kBS77ISofXLknQAfqpgTot8SCjBglGBN1Kf
 KrVWMGQgj8aydOr9IR08syX3x5ZMXK3cHatP4t+1dkIO7TFZUnJumIgvlnJzaJGK5g6e
 5nrrppNvqt0d3L2hcjBVhCLC7cGVlP2CTYe02YGhnKT3HuJwRmCwiaD2o48EjO1hzK9T
 gLXX25zSIyCIiw+G/74WYIm4Q84PAUWNTdo+fSETAlvBHF8m7hKEbyNWoyZHMnlW3cm7
 5zqg==
X-Gm-Message-State: AOJu0Yyolr0nTZLUzQ2xuKBd6OXQ0Fv8i6XJDWvSgPfORFSXGA7GHclV
 dYuTfuxihtlKsvhO0eYGX7OPztK12r28617Ke1hRM2BsFaVptop3wDKds7AIwsdduecnHijTNWy
 sgjPlbNKG2wp+lnZ12AXDZJ2r/+ZgC4p5StA4H/Z+jzDl
X-Gm-Gg: ASbGncuBW6yYinCVLAZYxGpEjXDWop2suZRRMcEX8rUy7aM1ftSM1vkJKzybbLY0KeE
 rCwfZy3ucIu2k6LS7Z2OOqUh1RK4wqlbjpteqaO/WEKqaa2W02blNbQ/V3qcmMHxhZcictSi9hr
 O/mCGbwJPW/59kLmsBOBSlN4M6u4HCxSyajVMt9OPArvADweMLwYhyCfMRcz4j1BkFMq3PFfd+H
 7hLfWQMK+rlJFTgSTUUmSa2Y7+/V74UoFBnG8cwGI7dqdVSZAuWAYO0idTA/lKPwzoNxrzuBCD2
 VPt/0gpegvynZlC3hknb48Qz3PLmUEXzwxWbNagP+ztdLGJ9moncUxbX9bn1QLJsyNo7Tu2HZ14
 xaSzWb9FNruyI4Ckw3YcmkQSln/uVT/AkANoTVx3cL9PYN+HXMylafgUISbFEZIlOr1I=
X-Received: by 2002:a05:600c:3b92:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-47939df2644mr110907495e9.1.1765291625138; 
 Tue, 09 Dec 2025 06:47:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEa35JmTeD7L6tWrS7arXiPrmAqwMo53un9MrEkXUxBDbX80AHCFZfn1R5JjeEYZDe+Qgehtw==
X-Received: by 2002:a05:600c:3b92:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-47939df2644mr110907235e9.1.1765291624759; 
 Tue, 09 Dec 2025 06:47:04 -0800 (PST)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d6eb1f1sm42972805e9.2.2025.12.09.06.47.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 06:47:04 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 09 Dec 2025 15:47:03 +0100
Message-Id: <DETRNKI1EOKX.1GQT599JGQR7E@redhat.com>
To: =?utf-8?q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, "Jerin Jacob"
 <jerinjacobk@gmail.com>
Subject: Re: [PATCH dpdk 1/2] graph: always count objects and calls
Cc: <dev@dpdk.org>, "Jerin Jacob" <jerinj@marvell.com>, "Kiran Kumar K"
 <kirankumark@marvell.com>, "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Zhirun Yan" <yanzhirun_163@163.com>
From: "Robin Jarry" <rjarry@redhat.com>
User-Agent: aerc/0.21.0-39-ga8d4735cf219-dirty
References: <20251209085028.115203-4-rjarry@redhat.com>
 <20251209085028.115203-5-rjarry@redhat.com>
 <CALBAE1OMwTX=a5i56G_sPXicw=17ozvb4PBfak0ev2Ps3xwuGw@mail.gmail.com>
 <DETKJKSUL9XG.1CTKW09I3UWSB@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655C8@smartserver.smartshare.dk>
 <DETNTVDMT8U6.307XVRW7VTBIE@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655CA@smartserver.smartshare.dk>
 <DETP2Q0QF39V.1KWT5Y2P9RLD4@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655CB@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655CB@smartserver.smartshare.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EFpWL9ikPXA7pEgs_S0Zm-jPsCXgOoSyEmVZ4HbkNv0_1765291625
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Morten Br=C3=B8rup, Dec 09, 2025 at 14:45:
> Sorry about not being more clear. I meant: "Then, if
> [RTE_LIBRTE_GRAPH_STATS is] enabled [at build time], the total_cycles
> stats can be controlled by rte_graph_cycle_stats_enable()."
>
> I proposed that you add your rte_graph_cycle_stats_enable() to control
> the total_cycles stats, and leave RTE_LIBRTE_GRAPH_STATS as it is now
> (i.e. to be able to disable all stats at build time).

OK I see what you mean. I will include these changes in a v2.

