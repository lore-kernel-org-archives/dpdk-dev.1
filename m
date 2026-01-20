Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F315D2ECFE
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 01:58:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 959EA40A75;
	Tue, 20 Jan 2026 02:58:14 +0100 (CET)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id 56E0E40A72
 for <dev@dpdk.org>; Tue, 20 Jan 2026 02:58:13 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b876bf5277dso891697466b.0
 for <dev@dpdk.org>; Mon, 19 Jan 2026 17:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768874293;
 x=1769479093; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPDgFzJYDqwMcCrvGrJosG0xPHafkoqdKGF5sqPVQJI=;
 b=QZJgC2kQbSsc+V62NUhFrSDJSP2h2Ri07TecPgg7mVilZZTwJA+gck7219tiiADzN6
 5EbHbmlUlxe+lfXUEkBcMIbam3mVBl4FZ4VYldBpOJCU7rPAB2R3B5PewpMahHVWNlpq
 yMmB85YFXsGU7d3mXc4Q64tNS6IiKm6UU2tMQ9B7BM78M4S4PJ+htIMc9tvszCcfOPxZ
 xMQR2TBVxsCaeFigkJuuiyU/1tfDHAgIu1uti/4wo/HoL/ycvaSjy+3AOIdi/pLjunrz
 5S0kEstk8kyhmK4D2iZAuAjxb+Bv1Hpiiae35t+TvC9CYLEb27sARe+FZZLtcXGUXgbV
 y6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768874293; x=1769479093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DPDgFzJYDqwMcCrvGrJosG0xPHafkoqdKGF5sqPVQJI=;
 b=WifZDqCCBXyAnJq3UBXDSAzXy1DH+jRwk1QgOoWnbiuugXNS8GoutpvK8vGXGGF2cf
 xoRVsnaSTu7qI7zpGeuU7X0oyAiAdpYE9XNgIUaqMJvoUYb6ul+rpMPrZZeq1ju13wfF
 7mr5EBjd0rHyZQ0YOURVqcOr00D5TpjpJusWxC5o/eNl4vaz4Po044GL2BRX/DVNj1WU
 b4+nPwN35wBGvmo8mmpdbe4ngnEzQIdmfOe4CKnlpyDMufF+OQwxrMlvvKecrNq96dHK
 fNHwdaZERVGeA+Q/5BO6/yB9buRFQkWrHJ5NhasjYMU6NHU4lX3OaTHVSd/C9CTZHpdP
 QVvA==
X-Gm-Message-State: AOJu0YwT3h1A1BPL1RvoiJXrLfp4zNrypHX750Roqb1XQ1TY0dcbJeS6
 DtwBU1c7pGBW/Z/TDkXd+ABGYW2ftFLQLK+Svf4vWYMM0Snjt3KujdnvbJ0WCfI5xZLa/AM9pJI
 cTcLr
X-Gm-Gg: AY/fxX7a8j+45JV8LfxkHTMblIfrMu3IPaUVPdMrudeOOIoKSEAf7ty5ENrUlvxtARg
 prxJG11V2OspvMJyKsm5tr/EIgXJZqzNjsP4nRZOfhqVCtTyzbyx7F/dCxFzlFNj84jDY/jt5d/
 VJiwNDNWFkiucv5AG7+HbEXSyN2rZ0z7UZ+0NPeNwLig6kA3HytkVKT1ZCdTYjKRES3RhQxmQFq
 9noa4/W//Diqn5VWWlBpirazCwJEJpqU22+Hno3qLBDRgkk+iPal57AAUfXV4suee1YVKIMQGDS
 gKYhPE31wiiMZuGJRR9TnvdjX6gT5FADgAmpwF0MtdQPxCH+7N7/tG2mt/GEcUPrt+ZOhzA0AuW
 +lzGwd+i+M2OxePRSABswOoWjXhWLAE/sI+Vqdax4dmQEDP29oKgMgegEnE3PrTafS4Z7z65Diz
 yhH3UbUav2b/BE9scdrQQvqGJd30JaTML46RNhp7SmIDDyqUxsrQ==
X-Received: by 2002:a17:907:3d92:b0:b87:8c1:1ea8 with SMTP id
 a640c23a62f3a-b8793857ba6mr1233759166b.7.1768874292849; 
 Mon, 19 Jan 2026 17:58:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879516900csm1342225366b.23.2026.01.19.17.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 17:58:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v2 4/6] test: fix unsupported BPF instructions in elf load test
Date: Mon, 19 Jan 2026 17:55:07 -0800
Message-ID: <20260120015759.301155-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120015759.301155-1-stephen@networkplumber.org>
References: <0260118201223.323024-1-stephen@networkplumber.org>
 <20260120015759.301155-1-stephen@networkplumber.org>
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

The DPDK BPF library only handles the base BPF instructions.
It does not handle JMP32 which would cause the bpf_elf_load
test to fail on clang 20 or later.

Bugzilla ID: 1844
Fixes: cf1e03f881af ("test/bpf: add ELF loading")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/bpf/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/app/test/bpf/meson.build b/app/test/bpf/meson.build
index aaecfa7018..91c1b434f8 100644
--- a/app/test/bpf/meson.build
+++ b/app/test/bpf/meson.build
@@ -24,7 +24,8 @@ if not xxd.found()
 endif
 
 # BPF compiler flags
-bpf_cflags = [ '-O2', '-target', 'bpf', '-g', '-c']
+# At present: DPDK BPF does not support v3 or later
+bpf_cflags = [ '-O2', '-target', 'bpf', '-mcpu=v2', '-g', '-c']
 
 # Enable test in test_bpf.c
 cflags += '-DTEST_BPF_ELF_LOAD'
-- 
2.51.0

