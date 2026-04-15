Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07A2F43828
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:52:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9174402D7;
	Wed, 15 Apr 2026 16:52:31 +0200 (CEST)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id 02E47402D5
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:52:30 +0200 (CEST)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-12732165d1eso17836965c88.1
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264749;
 x=1776869549; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zj59qWP0JauOpD4E82oTHtvNm1y+pWNDf7kPCKm6GWc=;
 b=DRQrknHGONQsiwUVC2KzRG5YVFWEpKCTigecJKxv5pVa1QUsO4ihUXAjHasQ4sJVdT
 dmlvdqZhvf7mARyeFak7Wc33PeX39jH13jwPM/aAExlJxplfR3Nndfa6gt+Vz2VTxNYa
 FXkNWNWwLprXf8C37JynWOMBzDpIPBIO8j6XoVhLzPjal/7TklwpWnk7kifz0dBLnn4d
 WujRVeRHcu5ky6tJtnmrAohTWiHexnQ7CIz6bFgbFokc6BwRBZQYXjXGgfgRJ/5NUiIQ
 RVuLFbBiEBHK/KkiMh8B9mqYtCT4QK+JCjXAUOrjlqgBpowcInl4LVsDz3j7dt3NhfrC
 ihWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264749; x=1776869549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zj59qWP0JauOpD4E82oTHtvNm1y+pWNDf7kPCKm6GWc=;
 b=ZgvO+QLfGPB709KxfRC3BICjM8N10LxN8Fg14Zs91DuDWKEQZoJzdsc1yl1Oif5oHV
 npqFWaaY27vFquPk2YbyqzNmq/YAdrDGwVvHgYFRPLqhBjdVRSabWmvO+76Pk9LajuCG
 x1iWzPLhfoMNu+wjm1/hdhmooK5eGaNVehnm3NWH1wGMjoDr6fRR1833FMp7vK9yD7uY
 ZlHqKDGy4PG5j7hBEGywZ2mLaq0VULS4O9CYZApmsUvBpBxFpng7BJjafYOfsplTIwWD
 DZfTaejW7sQXCWG8+g8ofnCY/v0B9qeMaREI/EGxaXjlPyPiShIWUCWIy+bKykgjyLra
 zytg==
X-Gm-Message-State: AOJu0YxDHXWLz/t/J8SOxBNr7c2kypkuNzW6jDFtiyfC4KtZNUJIBAKh
 cleJ8KhWqIci9unHzj/M9cd77e6hihVRXGhgiebvhdW7u7C/9sJnEk/WqVB9don7T43iWn6flsl
 1Y+sx
X-Gm-Gg: AeBDiet5lztr4aEIdzobJaX72FraJcH4qNr9LtCPs+n1S0LHGToGlkq4RVIOJ7atAHt
 9b7KjKNi+ul+f0QYBOHrterhf0aUJ2EI2Mluo8FL5Uba2gqh7q2RC3lIAaZZjtuciclM7yNb5yp
 46RmPszuEPTpDDYLdKfqWYS5pT4mrt+knBYbvEmw/vLKEe+oJfKEsDoi/ihkOQH9NbhwxSoNGiS
 Nnk4oDedUd1eytHZG8MDJw3gM/T0G9hU028W3hij7Ya5jFJLqR+LU+pwacqkrDCVHAL0Psjx+Bj
 eslmo3xEeDHRUkzli+Lyb7/lKFRG9NlixEdBYDKyclDcMhX8Rbscl/1GQWin84XrlWonndhHBS3
 91d3Qemrzp6QIoBhwmbGQQN4yPgic8FcAOPLal5huq1+Out87kz+FyvO7spPepGVRZwsZzOOx2+
 ++/Ys3rghybi4scTrA4qBNNn+29dNXKMUiwd54gXfQXFY=
X-Received: by 2002:a05:7022:6085:b0:128:ca83:5aa3 with SMTP id
 a92af1059eb24-12c34e37a7dmr11846093c88.1.1776264749003; 
 Wed, 15 Apr 2026 07:52:29 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c5e6a8778sm2055529c88.9.2026.04.15.07.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:52:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/2] af_packet: cleanup and test
Date: Wed, 15 Apr 2026 07:51:38 -0700
Message-ID: <20260415145226.259277-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413171836.123467-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
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

A couple of small patches for the af_packet PMD.
Fix indentation and add a basic test.

Stephen Hemminger (2):
  net/af_packet: fix indentation
  test: add test for af_packet

v3 - fix unchecked return value in test

 app/test/meson.build                      |    1 +
 app/test/test_pmd_af_packet.c             | 1174 +++++++++++++++++++++
 drivers/net/af_packet/rte_eth_af_packet.c |   64 +-
 3 files changed, 1207 insertions(+), 32 deletions(-)
 create mode 100644 app/test/test_pmd_af_packet.c

-- 
2.53.0

