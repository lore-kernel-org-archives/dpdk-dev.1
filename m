Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA5AF53D69
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:59:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6C504025E;
	Mon, 16 Mar 2026 16:59:04 +0100 (CET)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 568CA400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 16:59:04 +0100 (CET)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12732165d1eso6079979c88.1
 for <dev@dpdk.org>; Mon, 16 Mar 2026 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773676743;
 x=1774281543; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcOqGVp4+UlFj1rXFBlNdyUnn342Dvc+H2VhMysXNg8=;
 b=aMfwFGM4YV7AkN4Il0hoUm/U9TVeuiKdc+HEGylHXYTVSF+pZv6TQSRi355+yMxs1n
 yXzqc79ck4hZCeJe2kTSoYxmQh4TVB4B6TyHbxyleBU62f7K6LrDTgWiCPVRNfhBn5mW
 U5JDFk5HimQxWyEcsGjOdxAxuBcHHi03C07bWvWA871cVUjqbkbFDk7siR15W5DRFc67
 HRo+vuwfLG+8nPD+07BNYWEYcti52ygZ+NiFHAmO5RgMBxUrdCShT8gj1OLWmQU2iLDQ
 j35APeva5/qvfammZZjdnilrfb829xvguUzZlQVUZx0Jad3Wo26u8O9mI/DLtNavt8Fs
 6vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773676743; x=1774281543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FcOqGVp4+UlFj1rXFBlNdyUnn342Dvc+H2VhMysXNg8=;
 b=ThGn4IjEz96LUsm4xZVytTBL0XSzQl8qmo9MThW6EH//XNqQ5vAhjlnt/P17Cbksto
 ICt8INl9kLZvmkkgrel7RWb7MFa1R3E36GJX2EDOa+BastPnrZ4M810C9Rogi1lOlynB
 tLhU+i4nW2Wfti9c+9XJg1CdpGrwxyJx3pUmyyCdX42u5w7WCpBlTcG1r5sHKu3hwP5E
 OBPhMfijVMjfVjRj9ACT3DzXDRveSeFsKEQscAoX6EMIat/fQI1QNhCbrtb9nEWg5cox
 dgTgeDHBC6tLD8X3g6wZtGOFU4r4yBeMDnSbUN5OHw+wdwe4PULFOssLqjTFTmLsrYSK
 o3ew==
X-Gm-Message-State: AOJu0YxdLNZDt/y2iHL51gKoJoMktDxTqFLsHT1OE8Rh61uVaJwexte2
 YQqyDdaPH2Bt+e8kRnuU7H33Bi7rS1Z1HUlmexaTrMjv7h68vA1r/SsDYqKo3X0XnT8=
X-Gm-Gg: ATEYQzz9NbFUwpfDEJICEsyd848HF7o6E17GAWFEWPzCb+mSUQa/Z1pRtG3qzqWqe/f
 vKF4MvJDBCN/W9r4H8ZccYl9esFpGVhmXoKeA/PeY8Vnkj+QaWNDMulEGwZLnMjY/2lEHZsByqt
 YXyasHjFSaD+7k0l/kEFiGbjqCk3FvbQK+qgPqGtmRtFPhzZAupwS7u93Hbog9X35Xdi2X2l/Jt
 8XFudV4JMvcmGKMMpdkcu4e0+i9MtAj7U3UlKb6wpqbsQQJ3NlcqHaLQYlCqXHPa8ScQTOEO8ER
 mtEGkH+kFzhmiQndgcOH2w+i8VqV2Nh+YoGAKd8zo+J3dKTIIAE4iStp61vC9iumBd9g5DpQ1VS
 GZlp4+QqO2t7DxnJja/jTTcakfvjDbvPN0QRh3mhs8xAVleS+vrakAzTQgaserTOWUC24BlKD6Y
 QNM7R3z/K0pRQ55pokOWt2F+EcbbZ3ll5laVo=
X-Received: by 2002:a05:7022:784:b0:119:e56b:98a0 with SMTP id
 a92af1059eb24-128f3d17f5amr6292593c88.7.1773676742966; 
 Mon, 16 Mar 2026 08:59:02 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128f6295ebfsm12340931c88.4.2026.03.16.08.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 08:59:02 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:59:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v3 0/3] net/af_packet: fix MTU handling and add jumbo
 frame support
Message-ID: <20260316085900.4cc3158a@phoenix.local>
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
> 
> v3:
>   - patch 3/3: convert redundant data_size bounds check in
>     eth_dev_mtu_set() to RTE_ASSERT() (reviewer feedback)
> 
> v2:
>   - patch 2/3: fix Fixes tag to use 12-char SHA (checkpatch warning)
> 
> Xavier Guillaume (3):
>   net/af_packet: fix MTU set data size calculation
>   net/af_packet: fix receive buffer overflow
>   net/af_packet: support jumbo frames
> 
>  drivers/net/af_packet/rte_eth_af_packet.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 

Applied these three to net-next
