Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9685FDEE46
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 19:04:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11AED40272;
	Thu, 23 Apr 2026 21:04:29 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3153B40270
 for <dev@dpdk.org>; Thu, 23 Apr 2026 21:04:27 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-50e5dbd8e0eso45326311cf.1
 for <dev@dpdk.org>; Thu, 23 Apr 2026 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1776971066; x=1777575866; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jF8Mn8PmtIypIeXEg5M6+L+Cgoz26yWN1/aVr1Og9KE=;
 b=FDiNRQjJItAROtVNMZRm8iIzReIB5mip//XX5pesXIbRNpmT84czIUzWs8dYN4T7Qi
 5/vhK3TiN6mIRzrhF2xyyy/zWyvBi5eJUoediPzyikn/Rf+MrYrweG+QHoTegBEF9gHZ
 BZG93plf54TS/8D7c2VlEA5xL1LqQ0ilyJwA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971066; x=1777575866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jF8Mn8PmtIypIeXEg5M6+L+Cgoz26yWN1/aVr1Og9KE=;
 b=DCjnkQkwzKFCmhscCIGlyb762e1/C735wGDgPar/A+pdlMmSHjFB01zYIenysqHWIx
 r7xKiOsVUqfbeT09g7DncqsHhMI986V4mFBLAxNY7PIp9Hwwu3VuWiYsC7IOodPhfzca
 0DqlzDH6tIO4xc4S6it6w6dxUTJgizOcjCJeGeclHSP/vwq3VxwOtzBW7xxj30YnaRuz
 omY4rnRDogH/rChXjgkMVD3d/BQRQ4qNO9C0Z5z3DwkAwUAvW9LH/X8G/6JXdD+4F1YQ
 +0zEBne7+62hrg36xD4DTOFc5hnHLyQuAtF0P+ByoKjsG4Jt+r128iwq3WNsdGbvLxol
 jKgQ==
X-Gm-Message-State: AOJu0Yy6936gsYDJU4wU6BJl4BfTDjRfAJ4mJ/SkPlOeumzlZZUxMAlR
 WdQyozZ3ULhWpWy1xb9RpOnA9Kqgwq7SoE3P3U1DHhUutjL7ar9pgVDPN7IwPkMFLx0=
X-Gm-Gg: AeBDiesGqnjZTrI+LyYBMC/Jmig26fa2V3jR8JIR/uIJvCVzZs51NXBrEbPex69QVzP
 fZaBtEEqqU9AiK5cmTI5GDR4zpYy2R1gD7zUCDe/RhbNETuVkTzFrxwttjan4G/ePHHkagIx8tE
 E5tBzLSpVWmXDBcw5uDTBqGPiJaxRsxGYunb8Vj4yI4Dyl6M8XZt73/ZybyDIorTrcePE9ksNrT
 dmNiy1RIMP/Nv3W7ZX4FBXbZQsV/nqnqW7fGZ6BcLW0kzAwsDvHcMs6/gWQZ9QtJcsDqwYTp/MR
 zquXyHmPCWsCefetauIdLMg+Be8Rf12+M2+b0vypCOwRWUIwdpJOsp6d3ta7Ge5f6z8jsKQmlwF
 iqa7mJ5aQsomyCRUdRv5QZzafQERFA1zeupWByweRkei9cbtkRimYZRqoMAiViAEaUuCB2xO37f
 SyqEkpCOPzbnylpEiczk1oc2aM5VlfNLv790fukjZjHVNrsM7eLXyPGWM+3qOXX8L6CO/vFlpA
X-Received: by 2002:ac8:5d8f:0:b0:50f:c1d4:d9e1 with SMTP id
 d75a77b69052e-50fc1d4dd89mr123994961cf.38.1776971066410; 
 Thu, 23 Apr 2026 12:04:26 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50fc9715610sm34624441cf.10.2026.04.23.12.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:04:26 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 0/7] dts: move test suite imports from framework to API
Date: Thu, 23 Apr 2026 15:04:15 -0400
Message-ID: <20260423190424.41619-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423170331.33193-1-dmarx@iol.unh.edu>
References: <20260423170331.33193-1-dmarx@iol.unh.edu>
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

This series moves various modules from the framework directory
to the API based on which are being imported by test suites.

These include:
  - test_suite
  - testbed_model
  - exception
  - utils
  - context
  - params

This eliminates all test suite framework imports except for
the remote_session imports in packet_capture, as well
as the settings/config imports in smoke_tests. I believe these
imports, and what to do with them, should be a topic of discussion
in future DTS meetings, as I don't believe they should reside in the
API, even if they are being imported in test suites.

In addition to these changes, I've split the linux_session module
into an interface in api/testbed_model/linux_session and an
implementation in framework/linux_session. This way, users
can still import linux session if necessary, without exposing
the backend implementation.

---
v2:
* Integrated rst updates with corresponding commits for build testing

Dean Marx (7):
  dts: move test suite module from framework to API
  dts: move testbed model from framework to API
  dts: move exception module from framework to API
  dts: move utils from framework to API
  dts: move context from framework to API
  dts: move params directory from framework to API
  dts: separate Linux session into interface and logic

-- 
2.52.0

