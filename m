Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11F2CA101F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 11:35:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E9474065A;
	Fri, 12 Sep 2025 13:35:50 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 8E53940615
 for <dev@dpdk.org>; Fri, 12 Sep 2025 13:35:48 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-3e76766a172so494518f8f.0
 for <dev@dpdk.org>; Fri, 12 Sep 2025 04:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=i2i-systems-com.20230601.gappssmtp.com; s=20230601; t=1757676948;
 x=1758281748; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BtFIcEpP6kUvhaGpJtYZuk7WwTAZcwOlxWxVFtzTpGc=;
 b=FYXZUSc5HjO0dlvChrjoPs+W5qjPck5cq20j1NnmC+3tUaOQsWQCoOyT4ngKFhhqlq
 v00ocZo97WOFhwyFMmLSaCk1HYoQ2MsQ2inHgPBYjtqrs3Np87tmYslPCDaVfuiUqnOS
 m4TMgYFQKzxtYTcdqNEpB8sQrmzXPRG5w+PXhGThy3BzBM5c5osVSjGgqteH6+sfNzwP
 0PLhlKniGAnMakwf9SppAg11AIJ/P53PMbO/LsFZn9OeSJvK6cUkptUQqjOSveHSLoxr
 3MY7cIxHVLTLF6AG4SxeUVoeJjmDATfuxNFQXvW6vAb2YGHu/XzxXeZ1UHPeIeHOPxb4
 C/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757676948; x=1758281748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BtFIcEpP6kUvhaGpJtYZuk7WwTAZcwOlxWxVFtzTpGc=;
 b=ovsBxn1FqVBdlw1CdmJiu/E9NvH11VwSsCvJf08uV7ME05Hey50lqS98rf+NOBCJW8
 gtWs5Qu61hWGb43NXEkU6COkjfpEXrH7Q4CYyiw8Rd7DEDyWehc7IF1KCYuKoWKOtcs8
 Hs32kmhhr4/mgyPxi3dK31T633SOcEZVhLBzuq5QhPL3mWkCQu3eactO/wuaqLHoKNAt
 BlEiwkDmc+zqcGR+gpAHtGHMgs1eJlInhLuZfvJGbv7ecYdbtb2eeR38u+92vFfnpnKg
 ZIw0X0C/mbE3bBAirNdqXGX0occBDSknb1cYTpLSbNUdVMg9WnWJ30kn6vBhKh6EjmN6
 le5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhz5WjACV2y6wfxujYyaqJnMoN9cp7Xfg+k2eWpk9ZpqA9TMN9pQezKPzKJIGTpu4tWso=@dpdk.org
X-Gm-Message-State: AOJu0YxXNv0kL66s1EaJFJHhu/2BXhVNHFJFKYtJGWir90RbI9h4lmpY
 hIKNnZlEyM3Ei4KdQz0/3Vu8PpT3C/UL463tbVvB5w++BjjbmIiLb+MBxe9wuks6Ip3Bws35q9j
 ITzrdYJfLszTSvTvOgQFeSeDf8d3HuynzntU=
X-Gm-Gg: ASbGnctaeBsCp8Yifrb/lJxSBN6AFOZ2NvlQ7TZ6RxmDGNQYsEsxN8nL7oWhb1mjwhd
 iuPtOiBziVsh8qYa3mw0TpLNB7SYpD1VxSax0heCrRsh+gWKxWMBIhWWOqGwUf1yHRPLR/F2dXz
 7guWaGMi0nX0nFyAAOAP1RV0XWLcue8tVfdIuKHQ4CgvcU8hkoZzYe9qy2ut+8C3m5I4Nrw5jja
 OEyWA12OmkNIetKKLbHYNT7luRhRwbb+1H9IG15cqJpmHcADOxv+0dxhwd87tt+a+oEC9Sq2TfG
 V1SDvPHBAdwtoHxhYu8deIAr4Mnk6Ul1E3VgxxemSd13d9qq5VqgMjjkOEb0iIVmztEk0yuVT09
 e7F/yesCfr+Yf3Lcw+Z2sPqQEamXs5PNw3/w3rHOOWExnsrQ2x68u7i2gx/7r
X-Google-Smtp-Source: AGHT+IFkF8QB1rPJMT8RIBA/9qjle1599o330meCWUjM397/GZLDBXBLhBakxORZvP8DTf5VRFgx9g==
X-Received: by 2002:a5d:5850:0:b0:3d4:2f8c:1d41 with SMTP id
 ffacd0b85a97d-3e765797cc8mr2601777f8f.20.1757676947993; 
 Fri, 12 Sep 2025 04:35:47 -0700 (PDT)
Received: from machine.i2isystems.local ([176.240.216.131])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760787604sm6369187f8f.24.2025.09.12.04.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 04:35:47 -0700 (PDT)
From: Kerem Aksu <kerem.aksu@i2i-systems.com>
To: thomas@monjalon.net
Cc: linville@tuxdriver.com, dev@dpdk.org, stephen@networkplumber.org,
 Kerem Aksu <kerem.aksu@i2i-systems.com>, stable@dpdk.org
Subject: [PATCH v2] net/af_packet: fix crash in secondary process
Date: Fri, 12 Sep 2025 14:35:25 +0300
Message-Id: <20250912113525.396070-1-kerem.aksu@i2i-systems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912084758.354208-1-kerem.aksu@i2i-systems.com>
References: <20250912084758.354208-1-kerem.aksu@i2i-systems.com>
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
 drivers/net/af_packet/rte_eth_af_packet.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 6303e7878e..bdb4e06dbb 100644
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
index 85bc1201b4..de7ff63527 100644
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
@@ -875,9 +875,10 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		PMD_LOG_ERRNO(ERR, "%s: ioctl failed (SIOCGIFINDEX)", name);
 		goto free_internals;
 	}
-	(*internals)->if_name =3D strdup(pair->value);
+	(*internals)->if_name =3D rte_malloc_socket(name, ifnamelen + 1, 0, numa_=
node);
 	if ((*internals)->if_name =3D=3D NULL)
 		goto free_internals;
+	strlcpy((*internals)->if_name, pair->value, ifnamelen + 1);
 	(*internals)->if_index =3D ifr.ifr_ifindex;
=20
 	if (ioctl(sockfd, SIOCGIFHWADDR, &ifr) =3D=3D -1) {
@@ -1063,7 +1064,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
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
