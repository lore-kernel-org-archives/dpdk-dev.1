Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5258D606A323
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=BV6TCC9m
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C5004068A;
	Tue, 20 Oct 2026 08:59:57 +0200 (CEST)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97]) by mails.dpdk.org (Postfix) with ESMTP id 6F15240283
 for <dev@dpdk.org>; Tue, 20 Oct 2026 08:59:54 +0200 (CEST)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3ab4178ee33so2161165a91.3
 for <dev@dpdk.org>; Mon, 19 Oct 2026 23:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792479593; x=1793084393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8wxCwe73z9phI808yfncJpJNYWHE1iV/Iy0Ziaep91k=;
 b=ZgULrASTBu5mekn071L/l8nZFQ43JiaGNDIUoCQaWmgsm0QSB56CArueqbs3W6E1JD
 D9pFaeKEDSCZVLBRPCKwV+cUv012DaZMRjHGek0ZzRNBPs98cwFYIIcMKD8cyXyycPub
 7aMKzjQas6S7xHwRB2cy1YtD0mBtKw9JOwtHlLXeicKqZAJqU9uBC4E1sdIkiep3lT/1
 SGzWtom5o5NtZXwdat5ILCNMLAeJ5FEmh/WnHV6D1gyql9dRSsZ0vQqGOuKUVyw/ITgk
 Nof7m2l5+VrJnFVCJYOi+m/LdY0pi39UuYAckUHCyfxyqLyIa5JYj5rlNXD4JC7Ak1sZ
 IqYw==
X-Gm-Message-State: AFq9FYJGpBndxotjpIi6rJnFFSEnpiNqt23zRidhzUnkLEwqjQ34h9og
 wYQL1aF9ZUp2PCikb6cH8Dw1AoXGouyJWziOnIQTsN+TNNyRycbWRRyTW0IHgONgW7C+l/2J2Tw
 E0x8/nfil3wCRfQKToMdBMiWPofA+juJUoz6PFVJkY4ZD2zsADh/hzjLwA5iRMuhH96k0hWoO5T
 IZCSDlT+7PLo+sBdruQquoLR3jGmcTXoOCsf3C8WFDXjLsxgvUd4h8eYEYTyANqyLRNWo2lA==
X-Gm-Gg: AYBFou2VLok/fzFs+iHYr9WBIFxvPt8oEPqy9vPs8wB7Fsbp9u0WQcpNEBcFORIcMso
 jjIGi4xsVu+BJgjyz20PzLXl5XgMrEAmHjMT/LUY/U6Sap0SfsCHgF75IxYdmgyQ6gMM6jx+x3j
 viOUX6u8CDyH2x47oa4uiNhe4/HI19f6PxPduIC11hhAS5vP15RX680AfqYEX3Y+5wDLzKwjPlG
 PzOlEocsEbrxHgW6PL2sWwhwmSKiYb+7AdMdN97H5TFinXiSAi+0NDqW+p3kDir8Lm9qS5mmo2s
 x6YjUqs/NPLWqUq2v681u0YwfFrI09v7vxXmok5004FaA/g7/xOrX+Xot1jau/NSB2w9aD+FTVz
 1/HhDLwUve55do/JNvCFtqDMBjCZjkRhAay5MylWpn+uiwwiC0tL4sfuPxvfUL5kwivS7B+efiE
 d/p1vi8MvSjUrx3FyJBfqvWoNqPsInb1nzg5+63g==
X-Received: by 2002:a17:90b:4acb:b0:3ac:adce:60ad with SMTP id
 98e67ed59e1d1-3aceefbf7dfmr8131606a91.22.1792479593148; 
 Mon, 19 Oct 2026 23:59:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ad676a18absm1019511a91.0.2026.10.19.23.59.52
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Oct 2026 23:59:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9179a556c43so66531226d6.3
 for <dev@dpdk.org>; Mon, 19 Oct 2026 23:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792479592; x=1793084392; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8wxCwe73z9phI808yfncJpJNYWHE1iV/Iy0Ziaep91k=;
 b=BV6TCC9mjWYK55lI7Y6JIv7eF0noGsMxbZv0mfl7NFHuI/qzxS5UPEOnZ5a15i/b+B
 dO9zrqX5+QhNMInh/2Ieza+lie8W6mtDA1/mGGH3Gq2b/iDjtRALIoTA84nhaXu1vCY9
 iTwLDkslbeG53Tp2TXDEPxa1V2KFM5vf3zQUs=
X-Received: by 2002:ad4:5fc8:0:b0:91b:5d3b:4ad0 with SMTP id
 6a1803df08f44-91bdf2dd13dmr181165586d6.57.1792479591606; 
 Mon, 19 Oct 2026 23:59:51 -0700 (PDT)
X-Received: by 2002:ad4:5fc8:0:b0:91b:5d3b:4ad0 with SMTP id
 6a1803df08f44-91bdf2dd13dmr181165336d6.57.1792479591035; 
 Mon, 19 Oct 2026 23:59:51 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c03f30bffsm18917616d6.5.2026.10.19.23.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 23:59:50 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
	stable@dpdk.org
Subject: [PATCH v2] net/bnxt/tf_core: validate TCAM entry get response
Date: Tue, 20 Oct 2026 01:59:49 -0500
Message-Id: <20261020065949.1068047-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261005151720.1706054-1-manish.kurup@broadcom.com>
References: <20261005151720.1706054-1-manish.kurup@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tf_msg_tcam_entry_get() copies the TCAM key, mask and result out of
the firmware response using the key_size, result_offset and
result_size values returned in the response, without checking them
against the size of the dev_data[] array they index. The mask is
read from dev_data[key_size] for key_size bytes and the result from
dev_data[result_offset] for result_size bytes, so a bad value
makes the copy read past the end of the 272 byte array in the
response on the stack.

Reject the response with -EINVAL if the key and mask (2 * key_size)
or the result (result_offset + result_size) do not fit in dev_data[].

Fixes: a9597be79f66 ("net/bnxt: support L2 context TCAM operations")
Cc: stable@dpdk.org

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
v2:
* Split out of "net/bnxt: fix multiple truflow defects" (one fix per
  patch); this is the tf_msg_tcam_entry_get() response check.
* New subject and commit message; single Fixes: tag.

 drivers/net/bnxt/tf_core/tf_msg.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/bnxt/tf_core/tf_msg.c b/drivers/net/bnxt/tf_core/tf_msg.c
index aab8d05d81..c345d0a7ce 100644
--- a/drivers/net/bnxt/tf_core/tf_msg.c
+++ b/drivers/net/bnxt/tf_core/tf_msg.c
@@ -1243,6 +1243,16 @@ tf_msg_tcam_entry_get(struct tf *tfp,
 			    strerror(-rc));
 		return rc;
 	}
+	if (resp.key_size * 2 > sizeof(resp.dev_data) ||
+	    resp.result_offset + resp.result_size > sizeof(resp.dev_data)) {
+		rc = -EINVAL;
+		TFP_DRV_LOG(ERR,
+			    "%s: FW data out of bounds key_size(%d) result_offset(%d) result_size(%d), rc:%s\n",
+			    tf_dir_2_str(parms->dir), resp.key_size,
+			    resp.result_offset, resp.result_size,
+			    strerror(-rc));
+		return rc;
+	}
 	parms->key_size = resp.key_size;
 	parms->result_size = resp.result_size;
 	tfp_memcpy(parms->key, resp.dev_data, resp.key_size);
-- 
2.31.1

