Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D2F106ACDB
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 18:46:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19A12402AC;
	Thu, 12 Mar 2026 19:46:33 +0100 (CET)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49]) by mails.dpdk.org (Postfix) with ESMTP id 4A61240275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 19:46:31 +0100 (CET)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-409de4132b5so872422fac.1
 for <dev@dpdk.org>; Thu, 12 Mar 2026 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773341190;
 x=1773945990; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0gifONoD6C6tlp6NFpgQHjtk5byQARCBPO/2zTn9Fk=;
 b=Vc+Mr6jAmSKw61I0aM8DTPnhIDZ2YZV4bIPjF8JzqyFHAgVfUTeQY1j+HFfLXtfb0O
 qp6jIHujKt9uVz4RK7/iENX64pDwZ5bnz61m8VNFQcs7zXrSUIrVRaZUfXES4rbRbzgh
 ySq36yzx90xjDHD5eAEg/cOa79noRaHFyaGzgTryaeGgtiEp8uE5Q7VJpdOHp+Sz3dpu
 hoCXIG53UC/ht+nBasH1qOhpOfsZCls6EDeAMLiAgv/J/eR4U3m7KfJDAu4N9czVx7TO
 IsQgrCdqDe1VAw1rWSR91XUI1C7sYHTFs1lBZzq+NFs9GZCI3R3sFomoGMjrxkhmbz30
 3JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773341190; x=1773945990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L0gifONoD6C6tlp6NFpgQHjtk5byQARCBPO/2zTn9Fk=;
 b=rxIThG4U6UDBJ60fq+BuKV+RD8ZlYDiEnbuc2PE+Z6JjZZE477CMnj2lSsrQTAoO7A
 EzfaRNIQW31OmDUelUAWNtvHISKGa0kv4fxkGc8UjHicXw08PfGE9lkKqC/m85htpg0J
 9XnLiJxhW06rWw67gXBDx6d2fcmWR6p3ctJk2D4ks76YidP5oJM1eoSzZDl8Nl7AW07P
 c2vzcI9Krzel52sKG8OZ00WLiAYVNr0uH3s3yH3/5aDw+G11MjaxMSu0whIC4yopJ8Vg
 TBm4DM/JI7TCFdRwPsTFJzyjFff9B3PkuthFAO51SV++x3y2TQjVyxuhWj87Q2ceOCXn
 +rdQ==
X-Gm-Message-State: AOJu0YwajzHhmQyGAlbRJMmFKJZccwq9S2XEOgdgCXXKBSroRXXIQa1Z
 baOqUr3Js/Rj9RSKPlBxK+6mNWH4OALTRuAPWoNOH5OdAFmeSIAOyBmFBQ5cWAZQByE=
X-Gm-Gg: ATEYQzymrSf/ax8nelqoL66OctUVzlaLR+kjNl+dtxxTrGY9hbYvavgBq0ll8A5qMDL
 fmwNjCv88CXaRM7BEiQJOif1dWPqhMZ96ZXWDrW5SKg5Yfw8G+vsHURudDQZi7D1SNggpACBB8j
 VRxk7V9uNEOwaJOS3FTRKY6LpmLPiWSnf/icr7hhLZzJFCrD8rlnCXP5XaJF2RZT0s3T81uuRCj
 8K8q2gQRc+ElnzULuxmYS15s/HbOcY5gJXBYVsgFtTRhgFAp9rohWb3d/ZeAFvTQYp/Jjjs2dvq
 adiJ0rqaOPdsY+toSM5c1ooPG4Hr+nrrdl8fkgZ25gRmvd2D/HffjEdofQerSataDxs3p6We/sY
 LUmSM9pNlrx1SrvVL7yqCLa71i+qEUOW+ztCN2o8uJ63/7uTC4KHNpbNczD5if/47WV5+L5ZDRe
 mAbfQxKj9DojJ78hqLnVYSDBvlhdcryjVrbDw=
X-Received: by 2002:a05:6870:c244:b0:417:70c2:8537 with SMTP id
 586e51a60fabf-417b94025e6mr248591fac.25.1773341190495; 
 Thu, 12 Mar 2026 11:46:30 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e26e2c6sm6049046fac.7.2026.03.12.11.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 11:46:30 -0700 (PDT)
Date: Thu, 12 Mar 2026 11:46:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v3 0/3] net/af_packet: fix MTU handling and add jumbo
 frame support
Message-ID: <20260312114628.662c88b3@phoenix.local>
In-Reply-To: <20260310112122.2930093-1-xavier.guillaume@ovhcloud.com>
References: <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
 <20260310112122.2930093-1-xavier.guillaume@ovhcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 10 Mar 2026 12:21:19 +0100
Xavier Guillaume <xavier.guillaume@ovhcloud.com> wrote:

> This series fixes two bugs in the af_packet PMD related to frame
> size calculations and buffer safety, then enables jumbo frame
> support by deriving the advertised capabilities from the actual
> TPACKET ring configuration.
> 
> Patch 1 fixes the data size calculation in eth_dev_mtu_set() which
> is too restrictive due to TPACKET2_HDRLEN including sizeof(struct
> sockaddr_ll) even though the sockaddr_ll does not consume frame
> data space. The formula is now consistent with the RX and TX paths.
> 
> Patch 2 adds a bounds check in the RX path to prevent a heap buffer
> overflow when the kernel delivers a packet larger than the mbuf data
> room (e.g. if the kernel interface MTU is raised externally).
> 
> Patch 3 replaces the static max_rx_pktlen (RTE_ETHER_MAX_LEN) and
> adds max_mtu, both derived from the configured TPACKET frame size.
> This enables jumbo frame support when the user specifies a larger
> framesz devarg at vdev creation time. Since the ethdev layer now
> validates mtu <= max_mtu before calling the PMD, the data_size
> bounds check in eth_dev_mtu_set() is converted to RTE_ASSERT().

Applied to next-net and added your email to .mailmap as needed.
