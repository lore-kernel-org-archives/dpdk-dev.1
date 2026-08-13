Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEE2C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 22:57:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C32574028D;
	Fri, 14 Aug 2026 00:57:14 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 50E4D4013F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 00:57:13 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cad8076b01so4709355ad.2
 for <dev@dpdk.org>; Thu, 13 Aug 2026 15:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786661832;
 x=1787266632; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tM+DtG65ZFi7lf6EQnd3QHi9TWNycy+KN2ECtxDdFM0=;
 b=ckeLzHfsD36I2i0DkmElzNkekAAYkV+0opcEHrE1PsOecqB9qvoRAGQQf2p7f4D0yu
 cy1p27PP1/Muwh0nlx8BHFOed+j2e/29OV3OEsv14hZz7QKX02DHK7aigRsMx9GxhjRJ
 EDcLrwfpdOikJxO66oRE5/G0W8vEEsJSOyM8Xo0Wbl1tKx3mZpohXr40ruTtCFoAtY4d
 7GHFyGUzAtrB+gB7n6PJlnh0eiC3rLCLvSQpb3Li/kJ/F86wlt47DiD8meoKXElHGgb9
 c3BpU2sFBdCveQzgsLcBI4Xs/PSZWGlzQMsaN4LEHTBowlcVQjwSj8PjaN51XhzC3Wn6
 yB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786661832; x=1787266632;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tM+DtG65ZFi7lf6EQnd3QHi9TWNycy+KN2ECtxDdFM0=;
 b=mPuA4N9zEPvw3XDcdZun066EOw0JBlFjNSQi310oESh2EYMpVUF1sfv496Apj2Lfpc
 0uNMAkP2jT+JEqNtIgYRXzvjaW8Bg00YI0ClNNwElHn/8SsLvw6dcBG2PajjtF3Ao7Ny
 kUH+dvU9lV6HVooIfbf4k7nphyXNg3ga8XRLAQSrGZncC42RX4CBGL3Usy0+UK/qXIYS
 e9BSYyu1XC1ngiWqIOpO1vmBjEV4s6L4D7RAMg/ajTckfNxEeL4WmVF4TMcttaoD40Xh
 n3K4JIY2l+Wa4ww/MA9jIVwGNTUq3TLjWXQ5BloH1R5r9EvZkxo+cVtDQvZwQpt/zdU7
 5yBQ==
X-Gm-Message-State: AOJu0YzVCQT6UjbOb9DBmQkwYAMP0Fcud3LRsM1Qrf3YuF1vJ4DVTKB6
 m+wYwKRJKw7SAdBB45FjNd9+UcwR9o42jI6FqrB7PZ+ONDQHXGVTKJ4bpckzueUAqyDmjNGt4t9
 +kWUJ
X-Gm-Gg: AR+sD118qaS02I5urkpxAKV7JMMlp8dujANfwxHT3HXznoKF8GZTL4V/7+F+e/3rF3G
 QTNWU7ORBMh+ramGfet0jZ6Dk5gzDyTdHjt6BBaOOpLuqspMb2EscOPz9/XWVe5uWMHT+NyJsNp
 5KeuraF0a1WKORbVLAy0l7TnhwHfsa3A0dzzE8UU/Fhj8oNfkV+15QYAwI3htWOI25jUXND5gcK
 pAlUMxZ9g8xMfzKAtwcnJO4UxoBUyAhlvc1ZFjRyZ5o4nlxozqfRzHzXcmhv/rT3uFaQ3jDpGMt
 PDdHzXbIvjIwLEDHKbvWFn3RHC7HotZVdRmoJomoDxnDwgtJ9keC+KLPM3j7DJwJMqlKgNU3O3D
 osQNoohrer3DDdTPN55EIJDMFgOVMcuZ7ZZuLr/Hk4ypHJY8xKQuLHeHvkMYcfqFWA+9EJ2/Pxh
 FU9wjFVv9RxVvMeQ94eCWh5YVjzebJ/l3MUFXrt7Dc5QpddL5704j9xjvhasn79ZFmqSl1iH3Su
 9VgExgbBOUgFdKbxOYJFe9OR1qt8Q==
X-Received: by 2002:a17:902:fda4:b0:2d3:ac92:babd with SMTP id
 d9443c01a7336-2d3b0d091e3mr17810145ad.21.1786661832113; 
 Thu, 13 Aug 2026 15:57:12 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebf731dbasm14076831eec.17.2026.08.13.15.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 15:57:11 -0700 (PDT)
Date: Thu, 13 Aug 2026 15:57:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Randy Tice <rtice@cisco.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] eal/linux: harden uevent recv error handling
Message-ID: <20260813155704.1af0c707@phoenix.local>
In-Reply-To: <20260813201656.65649-1-rtice@cisco.com>
References: <20260813201656.65649-1-rtice@cisco.com>
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

On Thu, 13 Aug 2026 16:16:56 -0400
Randy Tice <rtice@cisco.com> wrote:

> The Linux uevent handler is harded for non-blocking receive behavior
> 
> Signed-off-by: Randy Tice <rtice@cisco.com>
> ---

Good idea, but the code needs to unregister the uevent fd on error.
Also, fix spelling error, decode error message, and handle odd
case where recv() got interrupted.

Something like (untested):

diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index ec408649d0..1985d5e122 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -241,11 +241,17 @@ dev_uev_handler(__rte_unused void *param)
 
 	ret = recv(rte_intr_fd_get(intr_handle), buf, EAL_UEV_MSG_LEN,
 		   MSG_DONTWAIT);
-	if (ret < 0 && errno == EAGAIN)
-		return;
-	else if (ret <= 0) {
-		/* connection is closed or broken, can not up again. */
-		EAL_LOG(ERR, "uevent socket connection is broken.");
+	if (ret <= 0) {
+		if (ret < 0) {
+			/* non blocking or interrupted */
+			if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)
+				return;
+			EAL_ERR(ERR, "unexpected error on uevent: %s",
+				strerror(errno));
+		} else {
+			/* zero length recv is end of file */
+			EAL_LOG(ERR, "uevent socket connection is broken.");
+		}
 		rte_eal_alarm_set(1, dev_delayed_unregister, NULL);
 		return;
 	}
