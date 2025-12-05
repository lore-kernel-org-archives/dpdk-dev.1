Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E41ED2CE0B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 02:30:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 703E840B92;
	Fri,  5 Dec 2025 03:30:06 +0100 (CET)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id B561240A6D
 for <dev@dpdk.org>; Fri,  5 Dec 2025 03:30:02 +0100 (CET)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4ee19b1fe5dso18653941cf.0
 for <dev@dpdk.org>; Thu, 04 Dec 2025 18:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764901802;
 x=1765506602; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=IGgk/GYuxA2RsWXv+FpQRqiHFGtHU1KLbnZHP7AX+pBdgaWWb26BrpbuNdI9xqFt7O
 QQoK/gvHQmeAyU/ddzqhFk+U/n1ApqSJ6VTFNJAqJknAV/kccuOjRDHit9UqKeBAxI6V
 DAHcHNeRJQ82ak4Nw1MqmjvZRQcn9Et7qqQk1MPd2D7Br6Bh8JJrWKVuACm3ES7x5P77
 YCKRFM9Xgbvt5mWbv95t11MpP75MKprphsjISWbAyN0S9SmE1TgBRydIRBv3nakeON6e
 0DCDVUuwZWhGvAO70Bd1bTtIZUH6XX+QOrGUN2wxOx0qRdHbsuLfBOg9DaPyEOwSk/AA
 CNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764901802; x=1765506602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=YbucWqLWiQue0M7GTclPcWbd4tUZRpB3po2uHm7q8duGmY5/W39i5m+BxiL0ELYq1G
 xFcoTHmw33USHKWQpGdnGymbrvHYbieKlKxMTj9ukuDTVukIneUMWTqdIzudJK5XER+6
 4TuSUG0Vfd8v0mW8tXee3VysqV1Wszuwwu6msen+ed9t8c0y9Xta4hcPFmoOx1WQj/hr
 MBi+gEtippS9Gx3/NyYSVMzMWq1HskIj8ftPmlryJubukheCLwqaDUFeQOMhyLmbmc+7
 V5w2eXDGPwMakv6N0xrWODQcxIojr/6wufhXkhzpe5n/fAdBsmBnf/UP6S0WieMsdcYV
 q5Vg==
X-Gm-Message-State: AOJu0YzZWea6lka7IGpWzUHYRv0i/LdyrXJLWU4MT5Vw3YSNxcf1/S9E
 8spSWrdFIWU+qWXf0dNYTiMM4Jsk1j0a/ylopeahVJoOKOFOEmHvLxzRYeeEvox0NH+iNRUb6Qr
 j7Q5v
X-Gm-Gg: ASbGncu18ZGqR9vWJc1+7veLcX5/RNjHCqNHvNh0JlCRkepgD67suI8ioLSO8wPRNta
 We3TJ3DfA3BbHP15YkIVKMo8TOzJOPfTYFCd92NNGtZmAMS7Vw6koy83C9aP/Qzz9Ya0Zk4fP7c
 4oWV64nvz2nfStjI2e5ixhVYCyYPVsffcgbH+V8cKp5fU4F6A454z1aF2nX1F9kJYM/Dpl5QqCI
 FTYNqMMiJh+PfHm4N27SDg/UPeTm52LYLmEove6h32aRqhLI6ImHLliVliQr6ydMg0r32rmx/fH
 Dlh73YU3/Cr4+ugN1fKi4fNAT+uhB6eU3U/g0xJHCkgzgBwzAjczwNgeMdflZpqU4wyLNBBr5UN
 r+5lytlSJtvH80ygP/Srr6q6WYc3ZLeCiIOUFcGLJ5pOI0ewROat/Ze3vbp1tfy+Zb3Yhu9a+JW
 NuiGdgHQFIVMChSvefnIzqEMshDElxAXCSZfSjlc0KOcCkllCI5w==
X-Google-Smtp-Source: AGHT+IG48ash11Nx5uWQn84mJUXuh34y2rk/xydhmj/6d734ahYfDeBV6weBjm6sXIWNlyjXsDJ9xg==
X-Received: by 2002:ac8:5a10:0:b0:4ee:4422:5a75 with SMTP id
 d75a77b69052e-4f0239d8b52mr77107501cf.14.1764901801659; 
 Thu, 04 Dec 2025 18:30:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02b7bd0b4sm15655861cf.22.2025.12.04.18.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 18:30:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 09/14] vhost: check for overflow in xstat name
Date: Thu,  4 Dec 2025 18:28:18 -0800
Message-ID: <20251205022948.327743-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205022948.327743-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
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

The snprintf to format an xstat name could overflow if called with
a long rte_vhost_stat_name. Check if that happens and warn.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/vhost/vhost.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index 416f082dca..540f4e0635 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -2200,6 +2200,7 @@ rte_vhost_vring_stats_get_names(int vid, uint16_t queue_id,
 {
 	struct virtio_net *dev = get_device(vid);
 	unsigned int i;
+	int ret;
 
 	if (dev == NULL)
 		return -1;
@@ -2213,10 +2214,15 @@ rte_vhost_vring_stats_get_names(int vid, uint16_t queue_id,
 	if (name == NULL || size < VHOST_NB_VQ_STATS)
 		return VHOST_NB_VQ_STATS;
 
-	for (i = 0; i < VHOST_NB_VQ_STATS; i++)
-		snprintf(name[i].name, sizeof(name[i].name), "%s_q%u_%s",
-				(queue_id & 1) ? "rx" : "tx",
-				queue_id / 2, vhost_vq_stat_strings[i].name);
+	for (i = 0; i < VHOST_NB_VQ_STATS; i++) {
+		ret = snprintf(name[i].name, sizeof(name[i].name), "%s_q%u_%s",
+			       (queue_id & 1) ? "rx" : "tx",
+			       queue_id / 2, vhost_vq_stat_strings[i].name);
+		if (ret >= (int)sizeof(name[0].name))
+			VHOST_CONFIG_LOG("device", NOTICE, "truncated xstat '%s_q%u_%s'",
+					 (queue_id & 1) ? "rx" : "tx",
+					 queue_id / 2, vhost_vq_stat_strings[i].name);
+	}
 
 	return VHOST_NB_VQ_STATS;
 }
-- 
2.51.0

