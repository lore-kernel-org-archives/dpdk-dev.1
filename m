Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760DEC83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:36:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D60840A72;
	Tue, 22 Jul 2025 19:36:08 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id CC60E40689
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:36:04 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-7e346ab53d8so515788985a.0
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753205764;
 x=1753810564; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=t09E5rqT6vFokQyH3MlpVTFwHpJmN/RxftAh3b46czn90GY9Ak97/wtBBTxyBDb9V9
 YL0fr8AzhuQaT44RvLN3akoBgeGWNohMKJtRcRXUV87be6wnM+Cau+xhidu4524zzydh
 5nmgS8QT8MnJ9+B1PIZVZ1htIQP+L3DsqSl9RAJ7KscDfSJ/KkhuqgIjlkxsNS8GrdTP
 OO03MRwUdOkWDe/ZqlQ6p8ijCLHJd55YgHtRKrUkqUQqIRjZjAijdHuAkZ60688Cjjn3
 vBz8SSw7Jls2j3trmta5KBZ4mP8YvWw4hZ/ACoXQUCEtEExPIcKGjXGS0fpwpJbWfv3v
 k17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753205764; x=1753810564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=lo6cBhUBErK3+SG5OL8EeQv0r88eLzRVfJMMNkc8I6iaIjd2V8uJvNFRSpDrNUFLPd
 41CgUy+NAkCBF5MHEtelal/AZ7p86GJ6uJT32758dHvJ+Dt9waIIXwwaOvp/CGqTYE4J
 KCV3FUYJJjGWgruCpHxIhD8LFQX1NJczrFSQ+ZaOutR3HIj0tHKeep2W+DHTKIeA0TPl
 //T8e/BsP1v7Nn3BTQUXIgCvCxUz5zhR2MUWHA5wsyoxnZXkB5gi6QK9vWojAN3KoyND
 7401FwRu8qZHIBnmH7vHecP7c+ZhucA+6OUegy53xQwWr+emrFMejyg8wtkudq84sbIA
 IlNQ==
X-Gm-Message-State: AOJu0Yz+neqz/nzrE8pnXlchBbNVIqrIotJjPqDGinaohJ+ZjDHSGjQZ
 GRTSOGHQTaQEHl0q0pM9gs5Zznu13c6RCcHKpMCpglqdbxddev9Iifl8w0hQT9TXcyU2Ds8HxGc
 CtmuY
X-Gm-Gg: ASbGncva9YDrfmxes8TKVINH/UJNeEtPDHmr9bz87XiTWiy4EFoNdRn8GAhP6FoZn2j
 zCqK57V1MY742iQBGAtjkRI4Tsszs9ILPbmHlvfJJi6/MgRCF6mjnZagisJhrG7njUJ/bZkFeda
 Lh/PQLskRz7rhArIKiCBJGGHxItNNgzAEEzvducSoAoHbgSk4/NgLXq/2Ps3gj5q54U0P/13AS3
 2n/suuGwnc0/44x/YjITxEP12PNaBE2oRIxyZvabs9cqMj/k9n4qxwvkK7fx27j7TrXGUqKOsxa
 pQixmjjzheqBxp6+y7Uj5yNuBAyAvddb1ZKycy2Irt0B2pt108hPHnPFnqx7CKe4bHDcR1y5rB7
 mMQ9lOFyfNQBY5Q0+uGufnL8R2qvTxMC6UnmgMmTk7t1TBtC+DghcTE15gdYkPYh4Y8RJRJHi4s
 kwArTOpQ4=
X-Google-Smtp-Source: AGHT+IHom1FO9tFVPu0gKSTGgL/VL9PoEUokIxEZuUgav1wMx97c5tgarkyujQDVDrrfnq1vjmrKgg==
X-Received: by 2002:a05:620a:6cc5:b0:7e3:33af:c45a with SMTP id
 af79cd13be357-7e62a20483cmr8375285a.49.1753205763991; 
 Tue, 22 Jul 2025 10:36:03 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b282aasm552155885a.14.2025.07.22.10.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:36:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 06/13] mbuf: add dynamic flag for use by port mirroring
Date: Tue, 22 Jul 2025 10:34:37 -0700
Message-ID: <20250722173552.184141-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722173552.184141-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
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

Add names for new port mirror fields.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/mbuf/rte_mbuf_dyn.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/mbuf/rte_mbuf_dyn.h b/lib/mbuf/rte_mbuf_dyn.h
index 865c90f579..72a31b22b3 100644
--- a/lib/mbuf/rte_mbuf_dyn.h
+++ b/lib/mbuf/rte_mbuf_dyn.h
@@ -327,6 +327,15 @@ int rte_mbuf_dyn_tx_timestamp_register(int *field_offset, uint64_t *tx_flag);
 #define RTE_MBUF_DYNFIELD_IP_REASSEMBLY_NAME "rte_dynfield_ip_reassembly"
 #define RTE_MBUF_DYNFLAG_IP_REASSEMBLY_INCOMPLETE_NAME "rte_dynflag_ip_reassembly_incomplete"
 
+/**
+ * The ethdev port mirror needs some extra packet information that
+ * includes information about the packet before it was copied to the mirror.
+ */
+#define RTE_MBUF_DYNFIELD_MIRROR_ORIGIN "rte_dynfield_mirror_origin"
+#define RTE_MBUF_DYNFLAG_MIRROR_ORIGIN  "rte_dynflag_mirror_origin"
+#define RTE_MBUF_DYNFLAG_MIRROR_INGRESS "rte_dynflag_mirror_ingress"
+#define RTE_MBUF_DYNFLAG_MIRROR_EGRESS "rte_dynflag_mirror_egress"
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.47.2

