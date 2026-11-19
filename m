Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF85606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N3A91B15
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB5424042C;
	Fri, 20 Nov 2026 11:13:18 +0100 (CET)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by mails.dpdk.org (Postfix) with ESMTPS id 13B9E400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 19:19:15 +0100 (CET)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-3adf9b1f5aeso11759351fa.0
 for <dev@dpdk.org>; Thu, 19 Nov 2026 10:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795112354; x=1795717154; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZGGw98vg2uWxDVlpZc2IVTlroTfDGxdGUeGQ+H/WG2M=;
 b=N3A91B1553umfgv2aMLMqtuPCWjE19MurPj9TSsL84H/nDtM/qyCs3YqyTwa7BzYIT
 iLy6142567yrrSX0k5dIij+0o9yCZ2GfEzb0EWf304kcuxMxHFS4R2VxhT2f/+viiDc5
 HmrX0nCrjlVrz+ykTGoTSQj8IZXEawUupstLCYyOKGFilSJMWW7m8mr76DnlS3ork4Yt
 voq6QI7e6irqA0DkJNCq6uukgRECGD170EIBH4Kk80DDczxpTo3CEX8qpu2Hc4zYe5ve
 ckY9UutC720rzTuQC3n+3Xr1TTjxWJK6tXh3d3QrWHhfPmpZUnN5siK94hcACo4L5Bo2
 nOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795112354; x=1795717154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZGGw98vg2uWxDVlpZc2IVTlroTfDGxdGUeGQ+H/WG2M=;
 b=CBiPVHIqbDPN82coDXCaxgGwp1ZqEByfu9wH6JqmLnbLeWY2vWIP2GraivEc8R8Dju
 uI6qItHTUy3tKs3ZGQS0jSiiQ6Z88v4Qw7ipZcHfjXzGiBH2IPRgAUdABJ5i3d7GoM2m
 njFPXe1aoYWeVXvqrSUz/HNMT1RWVsObpE1lC639stxF7IoQbe9CrqJn8Oc8IZFC39up
 YCkTddFX9fhYjHTO4QQnQRP2r//R5hfH2U0+dZi6O+xAR4ve2OdJjH1seNBAT78fp8FR
 c6VXzKzO7CVFeEcIv2zQtBaeEOSwIdlzI+iaHifR4DYsXistsliowFdznjpjb2LWs8gN
 BnEg==
X-Gm-Message-State: APuU4Z/1401WdoUd3oNA4W009b1ZrDVQTThz97F2L5756ICQjtQubZw/
 wXccU2QmFtIGsUWhdgdSqpwS0wk4bSyASmxRugapol5RQLJK54FceOgD
X-Gm-Gg: AYBFou3AkMOZc1ao/BhwtiwR5gUrainW58uWrVh1zIelBHA9DWIxujjR1NeUlSsMsC9
 fhH0/E8aQ8SDBtf1G9VG4A8jAjahZlfoO5a7og34gZ1Zzx1ymVnK5PEVlR7Qtcmf6MCe/kNEQYY
 HMahbZLV/WQ1Qtb9H6XT18oYC/hEr5z/OcZjKHVUpW5gQCu+pQnu2M3SehCuY4q5blodVNVWcOY
 hWrOxXaNgie8IfsHK5rYZe4pI2otJBcAN3YCO258z87upr6wtXuTEmqwl8zwZ/dx6ASXyQoV0tr
 hJtIPnZeRgN9Cm/fu4la8p1xGRn9TW3ODiePR/4HpkWUjc7kUd6CAVteT6bdWLVaGAEyddd4myH
 FZshkKbYUF/iv2Z1O2I8GCeGtC/RpztDf09DJPpVIiwB7ubYoKMi3lAzrUu71i0sJBr4eAC2/EW
 ySh5Wpfnau60DrM3HF1RdwmJGKZLI5q9QX5ruEy+SOG9Gs2fqaRWjTOcPTkgz1pEks1zVOsZw1v
 BSH4sLiR7mBbfQAhB0S9uJd25F41pBq3W+9JKWX33xfW292klDqS7ou+GwFDT9W1iHq98m57E2G
 BlrdoySjAhheuuDQB5ZI+1K820FYIEF85Tgk4TGkPwxW7uR7Rg==
X-Received: by 2002:a2e:be9d:0:b0:3a9:8775:5f11 with SMTP id
 38308e7fff4ca-3ae7b7b7c60mr6167611fa.4.1795112353989; 
 Thu, 19 Nov 2026 10:19:13 -0800 (PST)
Received: from localhost.localdomain ([213.24.125.164])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae8026aa69sm1582931fa.0.2026.11.19.10.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 10:19:13 -0800 (PST)
From: Mark Bulatov <ms.bulatov7@gmail.com>
To: Chaoyong He <chaoyong.he@corigine.com>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Mark Bulatov <ms.bulatov7@gmail.com>
Subject: [PATCH v3] net/nfp: fix wrong argument order in nfp_encode_basic
Date: Thu, 19 Nov 2026 21:19:05 +0300
Message-Id: <20261119181905.5454-1-ms.bulatov7@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261116172037.5347-1-ms.bulatov7@gmail.com>
References: <20261116172037.5347-1-ms.bulatov7@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 11:13:15 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nfp_encode_basic_qdr() takes dest_island as its second argument
and cpp_tgt as its third, but all callers in nfp_encode_basic()
pass them in the opposite order. As a result nfp_decode_basic()
gets the island ID as the target, and the island check compares
against NFP_CPP_TARGET_QDR instead of the requested island.

Fix this by swapping the arguments.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e6858e7e7cd3 ("net/nfp: move shared target logic to own file")
Cc: stable@dpdk.org

Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
---
v3 changes: Correction description

v2 link:
https://patches.dpdk.org/project/dpdk/patch/20261116172037.5347-1-ms.bulatov7@gmail.com/
v2 changes: Correction of the 'Fixes' tag and description

v1 link:
https://patches.dpdk.org/project/dpdk/patch/20261113142823.5918-1-ms.bulatov7@gmail.com/

 drivers/net/nfp/nfpcore/nfp_target.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/nfp/nfpcore/nfp_target.c b/drivers/net/nfp/nfpcore/nfp_target.c
index 0e7a5cbb05..239ffff869 100644
--- a/drivers/net/nfp/nfpcore/nfp_target.c
+++ b/drivers/net/nfp/nfpcore/nfp_target.c
@@ -728,7 +728,7 @@ nfp_encode_basic(uint64_t *addr,
 			 * address but we can verify if the existing contents
 			 * will point to a valid island.
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 					mode, addr40, isld1, isld0);
 		}
 
@@ -741,7 +741,7 @@ nfp_encode_basic(uint64_t *addr,
 		return 0;
 	case 1:
 		if (cpp_tgt == NFP_CPP_TARGET_QDR && addr40 == 0) {
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 					mode, addr40, isld1, isld0);
 		}
 
@@ -763,7 +763,7 @@ nfp_encode_basic(uint64_t *addr,
 		if (cpp_tgt == NFP_CPP_TARGET_QDR && addr40 == 0) {
 			/* iid<0> = addr<30> = channel<0> */
 			/* channel<1> = addr<31> = Index */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 					mode, addr40, isld1, isld0);
 		}
 
@@ -786,7 +786,7 @@ nfp_encode_basic(uint64_t *addr,
 			 * iid<1> = addr<30> = channel<0>
 			 * channel<1> = addr<31> = Index
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 					mode, addr40, isld1, isld0);
 		}
 
-- 
2.39.5

