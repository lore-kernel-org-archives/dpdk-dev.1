Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D6606A31C
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Nov 2026 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ePP5UZNa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 277114013F;
	Sun,  8 Nov 2026 17:22:17 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 1F5FD4003C
 for <dev@dpdk.org>; Sun,  8 Nov 2026 17:22:15 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3b12cb3c37bso63448a91.2
 for <dev@dpdk.org>; Sun, 08 Nov 2026 08:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794154933;
 x=1794759733; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NYhjYqQglmdVcuwyMo+mKLuJxzXDYPXA3pu3+fTPIIE=;
 b=ePP5UZNadjsSANt701+tjFKDkZnrv/xVKE8QVeF+8dqy/EaBIZXnoRXSyA9+fO0byO
 TWzor4OVedlk1cR3O18GIwxRXqy6R9OOCxhCcNVr+o/wuVebLiGhffNeP+NjASPpIRMY
 mbeaRS6eujMbJbK7tEVFX+Qjkd8HXwU0S/3xe/+/bERGIWHEC2j4J0ijejd4FFGBxyzy
 AfeDQUd7djo8ln6wS9cmAKUXHulYqxtKU58g7M1Bxad53SMv6MdV1UFm8o8O+EZvGvd2
 0GbCXB9zGnjiSY1VDwAdPA+Fz68OX9iY5gio6tVqfZ9w+lnwR78+qZYMDoR/o40YBMqF
 6/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794154933; x=1794759733;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NYhjYqQglmdVcuwyMo+mKLuJxzXDYPXA3pu3+fTPIIE=;
 b=oJR8ZI6UbMHecnK7MTAzZ9+H0UcmNG3o72rEm1Njha8fCtECJj8B9rV6RE0Npu9I7j
 Gr1Rew7i9FMt9lpr46rVtbWlBRAFuhNdmfBO5a3S7KIqGL8zb5KwQJlo1vIu+4Z8PpfN
 MO2r0+ASdYTVyUNXk++9hnVmHcQ8t3T11c5dW1jWiKOWaYXDqQ4B1+FT1sCiCcPzT5Dc
 GZBAIoWCcoHcPeSmLXLz5iIScgySA6wTY/dXv5H9xfBwb7T/Brm3rHkQn6ni/dyKgQ7E
 TDR/ugw//J5XBF+cV5iJ22cQr2QkE7DIk47bxce10vvsp7mo6wrSCHW1TIWWfcP+h0Ax
 WEBA==
X-Gm-Message-State: APuU4Z+2Z0pqDauOcrcrB4rsBLadKjqgZrOucHUkLImSx8z3Id4fC+oC
 Vt6/lf7Tq3tDU4z6LEMldEoTgSYtxt6UqppLk/w6VVo3W7dfgr4Tuis5Ylrk8u9Lda0=
X-Gm-Gg: AYBFou28YZMA1flLKHYMgpVHOn1xfQKcnhNZANc0Mjd5eWE1z0cZZedy4oil4Kj1uFd
 MrYo9h6LFOeWNiAOGL8JGmE/hQIBKLSu8HQcCVGgjQxS7OgsBBEkk8i1jU5CUFijlt4dRl6Y2dt
 iYt2Qfg1/XDA+T0Sy0THQlimkYVijGf9yFvYUsh6qPqOFQdtM3is0HsMD9fcjYsFGvlx0nNMSAN
 /EKU+goeDkXBJ3QVYFyOQTz3Mvv8o6MPnKVgU1tW6ERMF34J/H4sZv9vFgVeDO96zboiNm6qBFm
 ZfZssUnRoXsnkRpDHIAGs0FGGzsO2L7QV/JUODDsk3vVKQWZoQI061qIBMQAwLT5tN+w1gmf19h
 /kuZ1M9ySJkoCKpXhwH8bMVrTD32PX9fDOWA6mLEF/OlQHMGdl96vf12AN2CCEzUZAQw6TXLs3G
 xtLTprk66G3BddXKizGGIYFK4GsTB9lhy9AdTtFFaX/TEyAgd6s9csOzEB9U3Fu8/Cb2B8wD5kE
 kPU5qjNSZRFz71MubaOREjefMEhOQze+tabEzK3KoJShqHhjkAoxJDCbB4S1NWXmwaAYrDxYpmM
 OhlqqWQdDK4u4G9zRbcVo9pK4zI/qLQqKLDq2bl69b+pvGmMZcNY9gpK1TkFQPwbLc809w==
X-Received: by 2002:a17:90b:3c0a:b0:3ac:fe93:a731 with SMTP id
 98e67ed59e1d1-3b12d4b1908mr1386253a91.56.1794154933415; 
 Sun, 08 Nov 2026 08:22:13 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1058d2faesm7847145a91.14.2026.11.08.08.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 08:22:13 -0800 (PST)
Date: Sun, 8 Nov 2026 08:22:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Frank Dressler <frank@dressler.pro>
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 ktraynor@redhat.com, Bing Zhao <bingz@nvidia.com>
Subject: Re: [PATCH] net/af_packet: fix build with old kernel headers
Message-ID: <20261108082211.1f190f4b@phoenix.local>
In-Reply-To: <0374e022-3c41-4a6b-9464-7f879ef02ce1@dressler.pro>
References: <20261106142756.241131-1-bingz@nvidia.com>
 <dd205eb8-4741-452e-8490-16d157e1bb1e@dressler.pro>
 <0374e022-3c41-4a6b-9464-7f879ef02ce1@dressler.pro>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 7 Nov 2026 11:11:54 +0000
Frank Dressler <frank@dressler.pro> wrote:

> On 11/6/26 14:27, Bing Zhao wrote:
> 
>  > The PACKET_IGNORE_OUTGOING socket option is used unconditionally,
>  > but it was only added to the uapi headers in Linux 4.20. The build
>  > fails on distributions shipping older kernel headers, like RHEL 8
>  > (kernel-headers-4.18.0-193.el8, gcc 8.5.0):  
> 
> On 11/6/26 16:06, Frank Dressler wrote:
>  > If RHEL 8 uses Linux 4.18, [...]
>  > If DPDK needs to stay compatible with RHEL 8, [...]  
> 
> Short version: RHEL itself does't seem to ship any DPDK that is too
> new for its kernel. The RHEL 8 compatibility requirement may instead
> come from NVIDIA's DOCA, which ships DPDK 26.03 on RHEL 8. If so, the
> question is whether upstream DPDK should support that combination, or
> whether it is better handled on the DOCA side. Details below.
> 
> Bing Zhao, is that the use case behind the patch?
> 
> Details:
> I read too much into Bing Zhao's statement that the new code does not
> build with the RHEL 8 kernel. That statement is true.I incorrectly
> assumed RHEL itself ships a DPDK version that is too new for its
> kernel, which is not the case.

The important parts that were missed here.
 - flag should not be accepted if underlying kernel does not support it.
 - failure should be at compile time not runtime.

Either remove this part:

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 44f82c0309..ecd4a9801e 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -32,11 +32,6 @@
 #include <unistd.h>
 #include <poll.h>
 
-/* Added in Linux 6.2. Older kernels ignore it. */
-#ifndef PACKET_FANOUT_FLAG_IGNORE_OUTGOING
-#define PACKET_FANOUT_FLAG_IGNORE_OUTGOING 0x4000
-#endif
-
 #define ETH_AF_PACKET_IFACE_ARG                "iface"
 #define ETH_AF_PACKET_NUM_Q_ARG                "qpairs"
 #define ETH_AF_PACKET_BLOCKSIZE_ARG    "blocksz"


Or add a bunch of #ifdef like this.

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 44f82c0309..6ffdfd8524 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -32,11 +32,6 @@
 #include <unistd.h>
 #include <poll.h>
 
-/* Added in Linux 6.2. Older kernels ignore it. */
-#ifndef PACKET_FANOUT_FLAG_IGNORE_OUTGOING
-#define PACKET_FANOUT_FLAG_IGNORE_OUTGOING 0x4000
-#endif
-
 #define ETH_AF_PACKET_IFACE_ARG		"iface"
 #define ETH_AF_PACKET_NUM_Q_ARG		"qpairs"
 #define ETH_AF_PACKET_BLOCKSIZE_ARG	"blocksz"
@@ -44,7 +39,10 @@
 #define ETH_AF_PACKET_FRAMECOUNT_ARG	"framecnt"
 #define ETH_AF_PACKET_QDISC_BYPASS_ARG	"qdisc_bypass"
 #define ETH_AF_PACKET_FANOUT_MODE_ARG	"fanout_mode"
-#define ETH_AF_PACKET_IGNORE_OUTGOING_ARG	"ignore_outgoing"
+
+#ifdef PACKET_FANOUT_FLAG_IGNORE_OUTGOING
+#define ETH_AF_PACKET_IGNORE_OUTGOING_ARG "ignore_outgoing"
+#endif
 
 #define DFLT_FRAME_SIZE		(1 << 11)
 #define DFLT_FRAME_COUNT	(1 << 9)
@@ -110,7 +108,9 @@ static const char *valid_arguments[] = {
 	ETH_AF_PACKET_FRAMECOUNT_ARG,
 	ETH_AF_PACKET_QDISC_BYPASS_ARG,
 	ETH_AF_PACKET_FANOUT_MODE_ARG,
+#ifdef ETH_AF_PACKET_IGNORE_OUTGOING_ARG
 	ETH_AF_PACKET_IGNORE_OUTGOING_ARG,
+#endif
 	NULL
 };
 
@@ -1002,6 +1002,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		goto error;
 	}
 
+#ifdef PACKET_FANOUT_FLAG_IGNORE_OUTGOING
 	/*
 	 * Set the flag opportunistically if multiple queues are requested.
 	 * It takes effect from Linux 6.2. Older kernels ignore it and the
@@ -1009,6 +1010,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 	 */
 	if (ignore_outgoing != 0 && nb_queues > 1)
 		fanout_arg |= PACKET_FANOUT_FLAG_IGNORE_OUTGOING << 16;
+#endif
 
 	for (q = 0; q < nb_queues; q++) {
 		/* Open an AF_PACKET socket for this queue... */
@@ -1053,6 +1055,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 #endif
 		}
 
+#ifdef PACKET_IGNORE_OUTGOING
 		if (ignore_outgoing != 0 && nb_queues == 1) {
 			rc = setsockopt(qsockfd, SOL_PACKET, PACKET_IGNORE_OUTGOING,
 					&ignore_outgoing, sizeof(ignore_outgoing));
@@ -1064,6 +1067,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 				goto error;
 			}
 		}
+#endif
 
 		rc = setsockopt(qsockfd, SOL_PACKET, PACKET_RX_RING, req, sizeof(*req));
 		if (rc == -1) {
@@ -1314,11 +1318,14 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			fanout_mode = pair->value;
 			continue;
 		}
+
+#ifdef ETH_AF_PACKET_IGNORE_OUTGOING_ARG
 		if (strstr(pair->key, ETH_AF_PACKET_IGNORE_OUTGOING_ARG) != NULL) {
 			if (parse_uint(pair->key, pair->value, &ignore_outgoing, 1) < 0)
 				return -1;
 			continue;
 		}
+#endif
 	}
 
 	if (framesize > blocksize) {


