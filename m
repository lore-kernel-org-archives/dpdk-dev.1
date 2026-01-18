Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEC5C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:18:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80E5742E7B;
	Sun, 18 Jan 2026 20:14:46 +0100 (CET)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id CA11A42E79
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:45 +0100 (CET)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-652fec696c9so6407209a12.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763685;
 x=1769368485; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAP02QZIueRTiwzAVTjWfX4ftfT5W6B3Qd+6OhoabWY=;
 b=AeekO3Ztg6ZByoY7Xxdj/ZcYikgnm6TzPwU1gl2asUqdnGDupUW63d1hdS+q7t9sVW
 z8kiDPDQ6fSXRxyyGCmkIa4zCmlsrHsHFcggsAs3/HkfyP4JCnk9dH4mRK6MaAzn82Jj
 f4eFwvQ6KLLmt+kAh+7Aj+g4heCfDGG2PQH4seZjUTcoFC/XSk22wo2/mCAcPRCmsS2A
 ewo1BDkXvA8ZhhjUkpbQTZ043xXRvV4b+t3xFAcqzKnv2ZmXVzXkM7OeD/ORrCrnEl7J
 vkJ1fTf2bAOdyQFeZq59YDP4FLGubJX0U4lGNVv3BuDro+T+UMbYButXIR2W4Z9CLf3b
 peJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763685; x=1769368485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BAP02QZIueRTiwzAVTjWfX4ftfT5W6B3Qd+6OhoabWY=;
 b=rxb+bCBKoWUs5RaAa/IMOB0AazrMnum13WFEN3UFXaITUWTQcYqfvfDp8lxYc2HaN9
 85LJzyX1dJGivHg/kbhMjrnZWhGumcgD8/HHFqKV4Swerhrg8QeKlBrsszyQw+N1cnT1
 uFzPbf2LF55pqb37kEkgArEucZ9MND1vRktWt95tdY3FAWgOFyfTl9NnAdvEbpCdsKh7
 DOMq1DVIs3EOQPF8whXWR+6vZnGVqd2tnlmky6j6RBGpmVRsqZaHYce5Fi82DOjNN0Ru
 WnAXZEl6IhNKovMWAcGpmt1CZcJOAWt5xjKPpMFR8vCcoOY5pgSZ3tk2P6WbZSZdwLGa
 zu3w==
X-Gm-Message-State: AOJu0YzVaNSacXoKeL8m/qNy0t6bddx+D6WeL3oyIGHdb6k80ZU64C71
 dsNffPa+VtIopDRik7/gvnjMJbtywl9KcbG9a8N6avyYTtZ8HqKCHo+f6c30nJAHkJOCD2qo7XG
 3Npvo
X-Gm-Gg: AY/fxX5vlZsTR/UZxMA+XokmYrf5pobEgJ4SDmT//hdYrdagqEepRoM7adSWuorEwx3
 74MOQ5d1U2wK9gknws98jyfiff2WkD5XsbmeWMGqyq1pnyr/QC5mU5YTWudfdDZ5xSSKYwr6pgd
 w9n41vXW9BcC6zCGGPELEJf9soNQXw4RjzpSAIn5Vyds7HzC/zRqRV+dx7Weq7Molxm85z+PdxS
 IuXNIGKItVICYAlW3HhQG3556Y1r4UsrBiobbMtk91UFySiHw7cm4zscsuAEhwyfnM35Bpt+Umm
 smCVaW4MtS2qut/MGmLI8dUCRS/8Rop2HQfLM68PqZB769TlhG1zO2Oa6AAo12Ln4swiY+/hNxV
 FEJIyOUxa3s8/2hUfk+mnnYuHgdNEcI9hTNAkY2aouR7kgW0s169srDCHcRrRl/l0p2CH/Do7Fa
 lo4zdpMv/bFozx7UIjCSBJ4SRC9dJ4vpJy/Kl9pFJIBLp7xBmGjbi3Fd5YdU2a
X-Received: by 2002:a17:907:930e:b0:b83:73ee:9dc0 with SMTP id
 a640c23a62f3a-b8793028f11mr697211266b.65.1768763685393; 
 Sun, 18 Jan 2026 11:14:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 50/54] doc: correct grammar in security library guide
Date: Sun, 18 Jan 2026 11:10:53 -0800
Message-ID: <20260118191323.241013-51-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct grammar issues in the security library documentation:

- fix "will contains" to "will contain"
- fix "in a optimal way" to "in an optimal way"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/rte_security.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/rte_security.rst b/doc/guides/prog_guide/rte_security.rst
index 5cfa39a71d..837acadfde 100644
--- a/doc/guides/prog_guide/rte_security.rst
+++ b/doc/guides/prog_guide/rte_security.rst
@@ -120,7 +120,7 @@ crypto processing the packet is presented to the host as a regular Rx packet
 but all security protocol related headers are optionally removed from the
 packet. e.g. in the case of IPsec, the IPsec tunnel headers (if any),
 ESP/AH headers will be removed from the packet and the received packet
-will contains the decrypted packet only. The driver Rx path checks the
+will contain the decrypted packet only. The driver Rx path checks the
 descriptors and based on the crypto status sets additional flags in
 ``rte_mbuf.ol_flags`` field. The driver would also set device-specific
 metadata in ``RTE_SECURITY_DYNFIELD_NAME`` field.
@@ -696,7 +696,7 @@ Security Sessions are created to store the immutable fields of a particular Secu
 Association for a particular protocol which is defined by a security session
 configuration structure which is used in the operation processing of a packet flow.
 Sessions are used to manage protocol specific information as well as crypto parameters.
-Security sessions cache this immutable data in a optimal way for the underlying PMD
+Security sessions cache this immutable data in an optimal way for the underlying PMD
 and this allows further acceleration of the offload of Crypto workloads.
 
 The Security framework provides APIs to create and free sessions for crypto/ethernet
-- 
2.51.0

