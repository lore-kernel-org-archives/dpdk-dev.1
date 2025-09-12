Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD02CAC582
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 08:48:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D14C4402DD;
	Fri, 12 Sep 2025 10:48:43 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id C2CA4402CC
 for <dev@dpdk.org>; Fri, 12 Sep 2025 10:48:42 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3dce6eed889so1554086f8f.0
 for <dev@dpdk.org>; Fri, 12 Sep 2025 01:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=i2i-systems-com.20230601.gappssmtp.com; s=20230601; t=1757666922;
 x=1758271722; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4SAi2CbcDIR+owXyHC7suafp3SPsyfhK+tlWic10ATw=;
 b=LpKwymzYRPzPGzL9CFzA258tmYwqggqvHc2ba6KUgkRV3BVJIN1if8c7h2Bg2J6leN
 +FSzDh81taiXGBaaozRM5zVMLR42J0lP0cOVtdyE9oaW7sLq43KrSYbQgLL80H4M/IWT
 /tlCh17ddojZl5LSYIBgZdQ/Pea5xCTwzzHZ8GTNivKlYPo6k3l4DhtzBCH1lOYf1H2m
 p6+GKnGTU2qPTpZEoM+SJTKfgetNNfLJRXs55iHicv6qUkIEvuMRcEeDo0t7+JXfYUyt
 bPmb0sHsnzrl+F2VAOJviouPK6V++TIxwAZoGBCoTgdoyzosvU6JBkUHqk2byxkuoL3a
 sIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757666922; x=1758271722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4SAi2CbcDIR+owXyHC7suafp3SPsyfhK+tlWic10ATw=;
 b=cCc3JqYWOw1eAhZA9pG8t2MRCRSQ2KKNbL3VyQJKMRSgF7dzn3jPhRyCLP+20y86Gz
 iakdwZi+NLLPLd/z1n2k1BfPjg6NZ8F0j9LItfa3gPbDvIs3q7RWAAqXSM3bon0uhPro
 MKVM0QMOnuL/DlvVi0BA5z8ljEAFfpbb8FKHlmU7HWuo/dl2TEfRnm1E9o/WLLZlgPAV
 mgaSTuW2lpl501hK+W0rt+JlKmzzVkv9OzRVOYiZRlsyHefl2p+7HhhUgqEB7fkfczV5
 oMdjoFhA/5gueCoTcqvp0yT7e4FRa9zFv6M1B8wdHfDzohBnu7Nv69t21mvoyZsiglf4
 yY/g==
X-Gm-Message-State: AOJu0YwPDJuh7EmWGXW542kCLtst4QWh8+7fFsca66k3VQFHhCxRYbnj
 ginpntJ7pfUTN6pDvzjKNMjZ5qVTW4IbSdy4fVUav9FaO2tiPDqoKDCx556KEQeurIO5m8Cu+aD
 656UVf2D17Q4VCqb6LacbKrAVve0Da4iqJdY=
X-Gm-Gg: ASbGncvoybM0krP+clSBl8YJQdv8kaBP/as+lAdNDWeMqu92ebV4mASOKh0w6LTW4Jo
 UDyC0bZpqnuKWa53UttjYW6+cRLkJmjwtvV/wo8BhXJBRcpogi3/Z86+vYVrW6j3XsvNvq5bKyb
 a1ALMgJJZyRi9IGFNBbSTzbpvr4gPcmkQxp5PexKa6c9xvivJVsCyH4Xd8DZRZzDYCIBdnrST4A
 P+P0Ae35ZzdKkzLO1Pdx7UqG2YlCGK44il7Z4odwzlJCAv+rX/IycXNHqCArgEHTVhcTh8QAKzK
 93/jHfTQYwzRz/gxFduYShvJgvY9E6cMOUOBa5I3qPIAlQzLVgdOs7PfRrsVfYhKYQEIXk6MSi1
 7CU2mG/hW/b9j/IDHeAA29xdmoTjyAFc9azeXs3d6KKO0LXs2jZT8P7evLUFD
X-Google-Smtp-Source: AGHT+IEyKt4Hoa+Jp0fv2h9CsVGDyMtOhVij/dZ2cRvzIysKeituKhM/36BQDIFKZmsD78dTghqEWA==
X-Received: by 2002:a05:6000:230c:b0:3dc:1473:18bc with SMTP id
 ffacd0b85a97d-3e765530b01mr2120164f8f.0.1757666922104; 
 Fri, 12 Sep 2025 01:48:42 -0700 (PDT)
Received: from machine.i2isystems.local ([176.240.216.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0372ae57sm53168285e9.8.2025.09.12.01.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 01:48:41 -0700 (PDT)
From: Kerem Aksu <kerem.aksu@i2i-systems.com>
To: linville@tuxdriver.com
Cc: dev@dpdk.org, thomas@monjalon.net, ciwillia@brocade.com,
 stephen@networkplumber.org, Kerem Aksu <kerem.aksu@i2i-systems.com>,
 stable@dpdk.org
Subject: [PATCH] net/af_packet: fix crash in secondary process
Date: Fri, 12 Sep 2025 11:47:58 +0300
Message-Id: <20250912084758.354208-1-kerem.aksu@i2i-systems.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-9"
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

dumpcap crashes when trying to capture from af_packet devices. This is
caused by allocating interface name with
strdup (i.e. malloc). Interface name is not accessible from secondary
process and causes segmentation fault. Use rte_malloc instead of
strdup to fix the issue.

Bugzilla ID: 1786
Fixes: 1b93c2aa81b4 ("net/af_packet: add interface name to internals")
Cc: stable@dpdk.org

Reported-by: Kerem Aksu <kerem.aksu@i2i-systems.com>
Signed-off-by: Kerem Aksu <kerem.aksu@i2i-systems.com>
---
 .mailmap                                  | 1 +
 drivers/net/af_packet/rte_eth_af_packet.c | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 73d573e400..fadf873d4f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -824,6 +824,7 @@ Kefu Chai <tchaikov@gmail.com>
 Keiichi Watanabe <keiichiw@chromium.org>
 Keith Wiles <keith.wiles@intel.com> <keith.wiles@windriver.com>
 Kent Wires <kent.wires@intel.com>
+Kerem Aksu <kerem.aksu@i2i-systems.com>
 Keunhong Lee <dlrmsghd@gmail.com>
 Kevin Laatz <kevin.laatz@intel.com>
 Kevin Lampis <klampis@solarflare.com>
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_pac=
ket/rte_eth_af_packet.c
index 85bc1201b4..6928fc200f 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -525,7 +525,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		rte_free(internals->rx_queue[q].rd);
 		rte_free(internals->tx_queue[q].rd);
 	}
-	free(internals->if_name);
+	rte_free(internals->if_name);
 	rte_free(internals->rx_queue);
 	rte_free(internals->tx_queue);
=20
@@ -875,9 +875,12 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		PMD_LOG_ERRNO(ERR, "%s: ioctl failed (SIOCGIFINDEX)", name);
 		goto free_internals;
 	}
-	(*internals)->if_name =3D strdup(pair->value);
+	(*internals)->if_name =3D rte_zmalloc_socket(name, ifnamelen + 1,
+									0, numa_node);
 	if ((*internals)->if_name =3D=3D NULL)
 		goto free_internals;
+	memcpy((*internals)->if_name, pair->value, ifnamelen);
+	(*internals)->if_name[ifnamelen] =3D '\0';
 	(*internals)->if_index =3D ifr.ifr_ifindex;
=20
 	if (ioctl(sockfd, SIOCGIFHWADDR, &ifr) =3D=3D -1) {
@@ -1063,7 +1066,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 free_internals:
 	rte_free((*internals)->rx_queue);
 	rte_free((*internals)->tx_queue);
-	free((*internals)->if_name);
+	rte_free((*internals)->if_name);
 	rte_free(*internals);
 	return -1;
 }
--=20
2.34.1


--=20
Yasal Uyar=FD:=A0*Bu elektronik posta bu linki kullanarak ula=FEabilece=F0i=
niz=20
ko=FEullara tabidir:**=A0**https://i2i-systems.com/email-disclaimer/=20
<http://i2i-systems.com/about-us/email-disclaimer/>*
