Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F10EEB56D
	for <dpdk-dev@archiver.kernel.org>; Wed, 31 Dec 2025 18:58:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B62E40611;
	Wed, 31 Dec 2025 19:58:22 +0100 (CET)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id 0D3A74060B
 for <dev@dpdk.org>; Wed, 31 Dec 2025 19:58:21 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-64d2c50f0d6so13391289a12.3
 for <dev@dpdk.org>; Wed, 31 Dec 2025 10:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767207500;
 x=1767812300; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+NMeswa2theOAvut4wIcMZr0ljnVMW9JxTt9oQ6V+Q=;
 b=OfkzFsoNVilJUoSrh1/e6Sh6o0wWFwLwz3rZ0BwjWZeQcSU0nh2laTx7fGpne2XmTW
 e1bW9OYozMxFQi8D4EecurRvS/LjwUe++cEW6FP1SPEhQK7J6qZmlXrpa9TBFWKM4p5R
 9+FDLw6+4ECtDDSg1T57+uYbAPCS4RtQT7ZNC1/lavCFeQ8XuRuijvjnoAh7yQoGUDie
 TJt5Os8w/0mmC9lgirqA0EZX/brLzzkOjKyaWCquJX4Xw4eiCs+eTVqpkgb7rZ4xd3Ze
 JKZO1rndguuWdEv4rNVJPudJeLnG5LdeisIvsowCuEthtZ1RL2HC+gIs5UIN0FfjvufP
 gLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767207500; x=1767812300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l+NMeswa2theOAvut4wIcMZr0ljnVMW9JxTt9oQ6V+Q=;
 b=Fxx6wmYWzw5RaWBdrOpE6oBgG8fpiQnkkg9Vd0KSwResXOE0ck7JUX72l9w6AQN8kR
 RXw8dcamue0AE+V7pAiDoMKtXwygryF5AmfzOCqthQ8PQ+0WyPIVpWWhwar3zuhwtS6A
 coaSgT8FKsOBAZ/VicHfSVoWn+tD4CZ4AuUqO4L7O3wTVZ01chVMyh/hyaX96jbbV7Ko
 WM0W8tJJ5h2OCfy60MJgivObV4KEii273KAiWKnEulhPUL5UUttVmqVgXtQgmCw5Wo/T
 6vVovcl2thPxh/WyXIYXu/tMG1F+PRSmROsozRzUW99CKUYH8CE1MM7rDTo6umUIR+Es
 tlWA==
X-Gm-Message-State: AOJu0YzcRehdrktrTwAUhPUm+eUnQlY74LdhPJCCxgtjHfPTHGmQbSPM
 MPlN0fpcguMPQU6J297whaiG6RCIOa86cmM6LYQnBpwPp1STg9JHJzUtf77ecfApf4LunElLvxF
 1ohkLS1g=
X-Gm-Gg: AY/fxX4rL1rFlqtYE8uxQPC2p/Xuljfi8UU/cntXxXlxxEoSHpxqQSCYOn2ULyM/VdB
 8a4lRsEgAUaPWYyK04gNlFxirJJXnkDKFYchadjBQcp2MnXoX8H/4hjOOCodbBa/hzFJtb0S6AO
 hEUgh0bcr2jX4gjvdHTILUPEPi6l50fxRXta+VFwl460YgK3pKwu1EZObYVVYT7vcS4l9nPCeA3
 9qAGs+keOg7hWRwFHmntHWVLKFlnOurrZg8hN1zjnv3foCxAH/yZuGPSH9JUB8v4Yv9XWyFQp53
 aXbQNValKWM1pnx8ezqNVHUASh/UUCEYMbtJne/nUpZoAaL1kTBMyyIkoYASpVuemqw40N4ja/j
 rpCVhy3TRPHfJ0EC338PTMGaBihzhQIsbVGuXw51YTxEeHFs0+o2cSGKkgnk0KBhrECsoPv9TEm
 1arT4dJdzRHFPBkyABBROJkFxF60Y33qxvoC+WrTsAOEhE/FuJQw==
X-Google-Smtp-Source: AGHT+IE4aveaxNHW9F72Ll8dHZqpSwAkZLntJKnyP/i1xtGEuJaJjEDCB9ivxosFMSgcTzuGglSSgA==
X-Received: by 2002:a05:6402:34cf:b0:640:bd90:350d with SMTP id
 4fb4d7f45d1cf-64b8e93c0e6mr32015020a12.1.1767207500175; 
 Wed, 31 Dec 2025 10:58:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91494dd3sm39000103a12.21.2025.12.31.10.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 10:58:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [RFC 3/4] net/nfp: replace /tmp with /run/dpdk
Date: Wed, 31 Dec 2025 10:56:27 -0800
Message-ID: <20251231185803.90528-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231185803.90528-1-stephen@networkplumber.org>
References: <20251231185803.90528-1-stephen@networkplumber.org>
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

Replace /tmp/0000:00:00 with /run/dpdk/nfp/0000:00:00 for the
unix domain service name.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/nfp_cpp_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/nfp/nfp_cpp_bridge.c b/drivers/net/nfp/nfp_cpp_bridge.c
index da7ea35d62..b8ef60f22c 100644
--- a/drivers/net/nfp/nfp_cpp_bridge.c
+++ b/drivers/net/nfp/nfp_cpp_bridge.c
@@ -334,7 +334,7 @@ nfp_cpp_bridge_service_func(void *args)
 	int datafd;
 	struct nfp_cpp *cpp;
 	const char *pci_name;
-	char socket_handle[14];
+	char socket_handle[108];
 	struct sockaddr address;
 	struct nfp_pf_dev *pf_dev;
 	struct timeval timeout = {1, 0};
@@ -342,7 +342,7 @@ nfp_cpp_bridge_service_func(void *args)
 	pf_dev = args;
 
 	pci_name = strchr(pf_dev->pci_dev->name, ':') + 1;
-	snprintf(socket_handle, sizeof(socket_handle), "/tmp/%s", pci_name);
+	snprintf(socket_handle, sizeof(socket_handle), "/run/dpdk/nfp/%s", pci_name);
 
 	unlink(socket_handle);
 	sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
-- 
2.51.0

