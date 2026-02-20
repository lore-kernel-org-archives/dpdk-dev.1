Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178C2C5ACD9
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:07:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9C074068E;
	Fri, 20 Feb 2026 18:06:36 +0100 (CET)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id D8A6F4065D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:06:29 +0100 (CET)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-506aa685d62so12495221cf.0
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771607189;
 x=1772211989; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/omJoVtSBuPtIyWBO+npMl3uPvGP9xe48jZLhu4cU/8=;
 b=q7OTPuvjXJ7kWSzrMpw5ZzkNpoGel+izEhCRjdBMhgewcPIAT2ALbhFzvAvp85R5dg
 qBlvAnV+sX5Aix6R8rqv9wZ1Ns55XApoOmqFDKB/lm3J2sAZd0Ias1YU3ymEOXN1O+L3
 TNx5vG8kDigqSmOoHSnm576EHOWz/nz+mrMpPuGIhArjSyh1/I0K09J2VUF6KD327E6Y
 +ubRl9RbU63tHmEar+Ynoa/SlIZexdeCeso+Pmbfa5s1a3vDKBK8eEq81pp3GHUQNtsZ
 u16Flp/ePYNYeXRuhuf2JDhzHUuO8B5sYuUnjA5heWtPJXFB4rbi4ltj+ksDcIcbxFPS
 OMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771607189; x=1772211989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/omJoVtSBuPtIyWBO+npMl3uPvGP9xe48jZLhu4cU/8=;
 b=aDYnHzBcMOVPPFmBSoUKXV1YaZEo1VcoCBEkuBb2BrKNEgOiON3sPUP71Y62w7Y50K
 OCmqrBzZ6era7lAHhsLOOUaKiqfJwx21IxK2/4RXCForWqZNs7a0kcwO87AY/KW5R8rt
 6hFAC2ssiZhgN/MoKYIN3IT8PM6UgmCJByDtzdgku3jIm708ijVZMv0mWJi7I5hZRlgm
 UzUgTZS9L+jub4VXoiPZqhB8PTc4PoftqkNdVYicdbh/rVRm9PY4SzIlgicrgdASog0q
 my3dajsSNvb0ibkGDQo+fk3K9cBuQUnTNUwv5ne/hEWcIjTty5Dc+W6E1IhG0RvThKHv
 IFLQ==
X-Gm-Message-State: AOJu0YybQFRZYijZMh29NrOUS4FdpgOWkgYjLHoWuud3FGRjyoDXMHSI
 lh5a220UA76hDDnsK31i7LPxt0UswNdPYe1l17xvuNdV2+5PKPKfyLOHrDKQNYANVoPnw90u0WY
 8+IAu
X-Gm-Gg: AZuq6aK7akn0sL9AH2QGLODZ9vNkdPiHHDRwBg0zYVhqTTcFLbafcBXPU9z1muWVuNv
 IWy612UsqgpXbjguT0LSQXPtra3xCH1wPatY/fLAIWIjnHcP5gmO7ONn+j0/b2dGX8g/Ji5RyyQ
 0PeTB/R/pNwaS+VVdOIMsugy7Z2pzzmDxDsp9dZz4VRVx2Jt+gGYcY8eD9fwYE9swmH9sd1fLnO
 8mpqXiVQqY2eZWwL46YaebdOWnkEU0V9qppwhr7Kj5KX+sdnlCJ1eFXFip03QthJ1C+LJORSzDY
 dRauUXdCbKHyMxDMcWUAmdnSBQe78s3Fh7ZofakqpuyhN/63HTRXtih/niyCHGfcfVoBjNPvPyh
 /sMwkrz4CDAaHAhw+hMbpMJaD5PsOn2UU4VDvOq3IJy/SvaZtBBRnP4Vt9UTZY0EXWwjlvbssc9
 SV85P/UF5eF3cxmlO3by6Zpqkc3GIYpB5S1+m6THUXkzz2hh+dsnYHgP8+YUNYaQ==
X-Received: by 2002:a05:622a:11c6:b0:4ff:b2a0:2b2e with SMTP id
 d75a77b69052e-5070bc66523mr8026961cf.46.1771607189130; 
 Fri, 20 Feb 2026 09:06:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50684bc39e6sm276277591cf.31.2026.02.20.09.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:06:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v4 09/10] net/tap: free remote flow when implicit rule already
 exists
Date: Fri, 20 Feb 2026 09:02:09 -0800
Message-ID: <20260220170614.75560-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220170614.75560-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220170614.75560-1-stephen@networkplumber.org>
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

When tap_flow_implicit_create() gets EEXIST from the kernel, the
allocated remote_flow is never freed. Add rte_free() on that path.

Bugzilla ID: 1880
Fixes: 2ef1c0da894a ("net/tap: fix isolation mode toggling")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/tap_flow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index 427faf75d5..da1e70019a 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -1625,8 +1625,10 @@ int tap_flow_implicit_create(struct pmd_internals *pmd,
 	err = tap_nl_recv_ack(pmd->nlsk_fd);
 	if (err < 0) {
 		/* Silently ignore re-entering existing rule */
-		if (errno == EEXIST)
+		if (errno == EEXIST) {
+			rte_free(remote_flow);
 			goto success;
+		}
 		TAP_LOG(ERR,
 			"Kernel refused TC filter rule creation (%d): %s",
 			errno, strerror(errno));
-- 
2.51.0

