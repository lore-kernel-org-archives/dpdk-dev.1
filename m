Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D440D6CFAA
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 00:44:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1C3340262;
	Fri, 23 Jan 2026 01:44:37 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id E6218400D5
 for <dev@dpdk.org>; Fri, 23 Jan 2026 01:44:35 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47ee4338e01so9608665e9.2
 for <dev@dpdk.org>; Thu, 22 Jan 2026 16:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769129075;
 x=1769733875; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gzeNinSANO2sPNGzD6zq3ZY+JkgK3cF3k1xDOCQ0BU=;
 b=T+RxxetoGqurxzR/8rKe2Rr8SuYZiuIRI8N7nwEkl3PjcxrO0+4/qJ2ZqegS+IscS9
 pU/C4ZY06b/DnuFZA8V835JYNzceGISEYJLzVIjBoG6su1eYMWaLSSqnHkBk8/hzSVKO
 us9292f0SBrLMuVvWwdrfr83dttoJgohw1J8xkLqUxJuFgL1uYTjf4i/8usTxhw12Qov
 j5P7mQSXX65tsiacLFOFmfUFBSksz0gjqPgc+JmhcAf59dylbFevkIS9mMSR+XfeQtsK
 QvLQwuSmbI+FbceFP9J5d1XF9vbwE23iMm7gQwfI3WAF50XOJEGSZ/YQ5hhZIdpuWxQN
 O2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769129075; x=1769733875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9gzeNinSANO2sPNGzD6zq3ZY+JkgK3cF3k1xDOCQ0BU=;
 b=hpH6szvFgsMnGAf9btRl75ilFZRCxg/gUcEK9gTtTAUHl+ji8ss4VLlEean1PLHIdo
 r1EgLJlSmNIf7eZkyjyXAm2QSMQ0alRDVICdDGLHDWM4VFpTJNlCDwTr4JNjaUlO6ZU1
 uZcRkGF8evVDFM8tCyNMJFEHlEoGpHgQdPszkSOWXmC/2xZVXrpJwZsRq1rXr/C2Jqb7
 RlsBA3tHi1qiIepub/wfywWSIupS2QaKErKEZ02trmuYaprKQjyGIFC/J3gkoeBTDTi9
 73yNKbjZ0+/nk93APHi7RxHqwrDsVTBxfQ83nrymHzbhPhjhAU3NqZizGTUGGsCO9dEU
 6Dvw==
X-Gm-Message-State: AOJu0YwkOCqq2YzPdaJoPbwqDx72/4Oiw5UTM9Gazzo1YayL8IgQQzDt
 +gYQtW9kAzWa/RMroXwdkOp2CJVTpsfBhf7CUoNoRqdH9U2826EdEeIq5TYRppexcqL98A4J+Ec
 c1xts
X-Gm-Gg: AZuq6aLtbfO03f90hnoVjdhV2a31LTtltN+C+iirUfNXQETyug2IdE2OxnXQX6oaoPD
 HO9byAyISotx+hnDaA61zL/IXhu/mPWbI8LopluUnO7IB/UtMaplW6Smmss5l0e8L4DJyBoqJQW
 tvHvGld+Uo4g70FmU3idgUUXDfZOs2fpwJ7G+dXd/o1v9LoSNaQsPsvF9RnPrjULMTzaaG6w1XW
 yU7QYtb4i6enQjnlJZe5s7c5tfQLx5cvNGPgLdXZv4eKzywfcyCDMrToP6Zh5tRByIk+vVs02eM
 gtKI+awSq349m+f058gBuD4bm9ZetWXhLSHv28YNdqJcJs5tZW+tLOy33eos8nDgELdV/OdY5I2
 x9SnojO5Txkgcejndurau2Z8q9Ii4EH1n/L/8TOd63HWorUkwX6HfBtz+w04RaZ3jXtO/7Acn8Z
 SPc9HwhOJB4uFuDB6edXNRUHErvRqdmdfUoK9HeIdvssJ8jENEOIuswWBhMLh7
X-Received: by 2002:a05:600c:5298:b0:47e:e946:3a57 with SMTP id
 5b1f17b1804b1-4804c9d9f23mr20602265e9.36.1769129074831; 
 Thu, 22 Jan 2026 16:44:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804dbda9edsm5668955e9.19.2026.01.22.16.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 16:44:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 0/4] devtools: add AI-powered code review tools
Date: Thu, 22 Jan 2026 16:42:18 -0800
Message-ID: <20260123004430.10951-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109014106.398156-1-stephen@networkplumber.org>
References: <20260109014106.398156-1-stephen@networkplumber.org>
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

This series adds tools to enable AI-assisted code review for DPDK
contributions. The goal is to help contributors validate their patches
against DPDK coding standards before submission, reducing review cycles
and improving patch quality.

The series consists of:

1. AGENTS.md - A structured reference document that consolidates DPDK
   coding standards, commit message requirements, and validation rules
   into a machine-readable format. This serves as the knowledge base
   for AI review tools.

2. analyze-patch.sh - Reviews patches against AGENTS.md guidelines.
   Supports multiple AI providers (Anthropic Claude, OpenAI ChatGPT,
   xAI Grok, Google Gemini) for flexibility and comparison.

3. compare-reviews.sh - Utility script to run reviews across all
   configured AI providers simultaneously for comparison.

4. review-doc.sh - Reviews documentation files for spelling, grammar,
   and technical correctness. Produces ready-to-apply diffs and
   compliant commit messages.

Usage requires an API key from at least one supported provider:
  export ANTHROPIC_API_KEY=...
  # or: OPENAI_API_KEY, XAI_API_KEY, GOOGLE_API_KEY
  ./devtools/analyze-patch.sh my-patch.patch
  ./devtools/review-doc.sh doc/guides/prog_guide/mempool_lib.rst

The multi-provider design allows users to:
  - Choose their preferred AI service
  - Compare feedback quality across providers
  - Avoid vendor lock-in

These tools complement existing validation infrastructure
(checkpatches.sh, check-git-log.sh) by providing semantic review
capabilities that static analysis cannot offer.

Future work could include:
  - Integration with CI pipelines
  - Mailing list integration for automated review comments
  - Fine-tuning prompts based on common review feedback
  - Better updating and error handling.
    AI providers are not stable.
  - Integration into contributing documentation

Stephen Hemminger (4):
  doc: add AGENTS.md for AI-powered code review tools
  devtools: add multi-provider AI patch review script
  devtools: add script to compare AI reviews across providers
  devtools: add multi-provider AI documentation review script

 AGENTS.md                   |  939 ++++++++++++++++++++
 devtools/analyze-patch.sh   |  534 ++++++++++++
 devtools/compare-reviews.sh |  153 ++++
 devtools/review-doc.sh      |  734 ++++++++++++++++
 4 files changed, 2360 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.sh
 create mode 100755 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.sh

Stephen Hemminger (4):
  doc: add AGENTS.md for AI-powered code review tools
  devtools: add multi-provider AI patch review script
  devtools: add script to compare AI reviews across providers
  devtools: add multi-provider AI documentation review script

 AGENTS.md                   | 939 ++++++++++++++++++++++++++++++++++++
 devtools/analyze-patch.sh   | 534 ++++++++++++++++++++
 devtools/compare-reviews.sh | 153 ++++++
 devtools/review-doc.sh      | 734 ++++++++++++++++++++++++++++
 4 files changed, 2360 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.sh
 create mode 100755 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.sh

-- 
2.51.0

