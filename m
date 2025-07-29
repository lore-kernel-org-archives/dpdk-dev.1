Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24250C87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 05:07:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AE6A40DC9;
	Tue, 29 Jul 2025 07:07:03 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id AF94940668
 for <dev@dpdk.org>; Tue, 29 Jul 2025 07:07:01 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b170c99aa49so3803327a12.1
 for <dev@dpdk.org>; Mon, 28 Jul 2025 22:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753765621;
 x=1754370421; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6zq+sH0lfX94idlh939p65QJkcxjoJ5VlQt0O59+eWw=;
 b=V66U+0E0Zggp2S0vY5pnigrXvRbGYqfMMQ0QTBLJwbUg+jgefnTokNrDVX/47ellro
 QEKZEz5W6pS1tLZVaK6P51Nx8kMC65F2/KUjAdEdVQYDqr+OWbIpswM4R9uv3Z9YDsHU
 ENNAcg951KsP5b+4K2yevpbPJn0HOSfGE1hesyFcCP602oWhXAwtA4wGO4/GA5TZYegS
 9SzEdIgRqUV+O1YZeOXEAUMQtWffcK8E1gvjOMqdvtI+dWyNCgiSowE2XcVV+n8qDRdu
 3+1dGdRvgBfH2tYy73S3vQsKykhIcxwQFSO2kA9w5xYdnE3tTxJ9Ax+sgXHu36DrlxnK
 XN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753765621; x=1754370421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6zq+sH0lfX94idlh939p65QJkcxjoJ5VlQt0O59+eWw=;
 b=Cmje2JBcESaAIX8ezFCrPY2jEJbDeIxuBMHVwR2YwVZvYWKtFl78iFYhVkjyfRXs3K
 2qxcyyCg7CPMUVVToGxGPas0/qimYOMQBE+F5jLgRnRv9065cF6qXsop7p7aCNsfU+Zl
 mFhZV6uGCo5380pZotrcKcRwUAsLN0HR2gxK/xJReeXiKQTYDqAu51H6Y2L+RC3fnCeW
 z7O2LhwnLghZkKC0jWTVk670CC48NhifzFHFFKTsXlP3lEN52/bnQ8lEV49EXe9yhYkD
 7ZBx8QxvTs1S2m4h5x/edJS/r1w0sKOzYF361yFp5/KbzNFDHkz6MIg26jLlDw+STbGM
 Ypiw==
X-Gm-Message-State: AOJu0YwGCL7HQWe7s8RZs2UOxJqHeo+DFBnOavhzvv1eYCW4Kj821g84
 XE5TiKtNynQ7OGsiPAg+GnTppfi+jx2AqzmlvvE11C6iTrMP92Xtw9hZZHILvWxcKPs02kCAxjv
 I9Dzj4ebLLA==
X-Gm-Gg: ASbGnctkzMzq+qYIZz4GGpFLVrhHbpZoti5est3gHVekNu0zrs9nLBKX21rNl40Vbqn
 FJeKofl2h3A0DjPB6nXtj4n1WLhzL9cC1Y84tDrHPo6pdvOlT6i3yibskMAN6Zwh20C3WKUUW3K
 BSB7DJqDnTv52rd2vSnHSVtbH0GxB9JHi3c8YfJct8+4F28WHbdmN9Qx/v+aT8ZDeNaXB0+nD+u
 SrXbJ/7UidwyKxFgwmaR9zqB+GmDW8xfcgAY148FhIS6vTlqbbw9zPRFyABIcCLglwTwS9Ft3x0
 sWFdFBcqhfV/n25OcYR0e49Su3p6rorS7mpO2bcWfefP29OEvkJB5JXJWInc1Ji6+xSi1NY+wvL
 2k+7ypFfw4H90SPluiKe1u/gcasNuFUnGKJatHxhbvAs4Tt9s7HFxjat91ThZBBpWbGLfC+xV28
 0gVWs9t8h7KzqwkSuswCX+DvY7
X-Google-Smtp-Source: AGHT+IF4bLq7/prRqvYXFwYRLEeNB8qsb4VUIj/ciqGbJdpCcjswtX3sODH91kj95B+WLYOUtoorfg==
X-Received: by 2002:a17:902:ebc3:b0:235:f298:cbbe with SMTP id
 d9443c01a7336-23fb301c29amr236931385ad.12.1753765620614; 
 Mon, 28 Jul 2025 22:07:00 -0700 (PDT)
Received: from localhost.localdomain
 (108-92-19-205.lightspeed.sntcca.sbcglobal.net. [108.92.19.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe327443sm67194205ad.44.2025.07.28.22.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 22:07:00 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dev@dpdk.org, ivan.malov@arknetworks.am, jasvinder.singh@intel.com,
 bruce.richardson@intel.com
Cc: thomas@monjalon.net,
	andrew.rybchenko@oktetlabs.ru,
	stable@dpdk.org
Subject: Re: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet
 packets
Date: Tue, 29 Jul 2025 01:06:47 -0400
Message-ID: <20250729050647.52745-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <e7c3c2b2-5f7a-eec4-cbd8-cd17ecec4c46@arknetworks.am>
References: <e7c3c2b2-5f7a-eec4-cbd8-cd17ecec4c46@arknetworks.am>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Ivan, 

No, it does not breaking testpmd or any other applications. 
Yes, the structure is correct in rte_net.h and comment as well.

You can run testpmd in rxonly mode and set verbose to 3, send the following packet from remote and you will observe the output as given below: 

pkt=Ether(src="04:3f:72:f3:7a:43",dst="C8:0A:A9:04:49:1A")/IP(src="19.168.1.1",dst="19.168.1.1")/UDP(dport=4789)/VXLAN(vni=4094)/Ether(dst="22:11:11:11:11:10")/IP(dst="19.168.1.1")/UDP()


port 0/queue 0: received 1 packets
  src=04:3F:72:F3:7A:43 - dst=C8:0A:A9:04:49:1A - pool=mb_pool_0 - type=0x0800 - length=92 - nb_segs=1 - hw ptype: L2_ETHER L3_IPV4_EXT_UNKNOWN L4_UDP  - sw ptype: L2_ETHER L3_IPV4 L4_UDP TUNNEL_VXLAN INNER_L2_ETHER INNER_L3_IPV4 INNER_L4_UDP  - l2_len=14 - l3_len=20 - l4_len=8 - tunnel_len=8 - inner_l2_len=30 - inner_l3_len=20 - inner_l4_len=8 - Destination UDP port=4789 - Receive queue=0x0
  ol_flags: RTE_MBUF_F_RX_L4_CKSUM_GOOD RTE_MBUF_F_RX_IP_CKSUM_GOOD RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN 

The length is 92 bytes which is correct but inner_l2_len=30 which is incorrect. According to standard, the following calculation is true of VXLAN header (50 bytes) and VXLAN packet size(92 bytes).

50-byte VXLAN header =(14-byte outer ethernet header + 20-byte outer IP header + 8-byte outer UDP header + 8-byte VXLAN header ) 

 92-bytes VXLAN packet size= (14-byte outer Ethernet header + 20-byte outer IP header + 8-byte outer UDP header + 8-byte VXLAN header )+ (14-byte inner Ethernet header + 20-byte inner IP header  + 8-byte inner UDP) 

This patch correct the inner_l2_len which is 14 bytes.
