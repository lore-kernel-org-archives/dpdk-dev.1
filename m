Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4036D3CC88
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:56:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C69A540E1E;
	Wed, 14 Jan 2026 23:56:01 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id 9E4804003C
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:56:00 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so2862555e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768431360;
 x=1769036160; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qkAN8vWgusKioRDpMEyqvlbRkDAllUzFHZ+jA6dIFG4=;
 b=oVrrk6uaACzzVACTMQUgoCc7p7tQu8kBbh72CER+KhDGhgGw9VF3zSGpp0Y8m18hJG
 rY6CqtbSPmIqleCafIlrXd8FP62L+2m9Ocfts9GdgDI7ipDy2kWHZJQJVPpFEUZ2exw/
 twP8L1mjzkIvakAjjN2UoioK2ASqlW1SpKOIyvHynGxtkqKTGsLRR4C02ZdKL9dJr3Om
 Fg6mtWtSJoYqLZQ5Dx3cn4yNphE7P5ZI2ajKX98hqmjBJM35Acxt7teau6GuVTcCpzMu
 X9H6L6D4T9vL6c1qo5SJVm4WUK7uX5E6I7FmmUObfSJHEMehyG5hmFG3elF+HP5r1XRy
 oUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768431360; x=1769036160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkAN8vWgusKioRDpMEyqvlbRkDAllUzFHZ+jA6dIFG4=;
 b=iANsAp0M8oTsN29BZkfn63V8JWfGU7cFkrN500uFyPAzFOFfH6ixJLhYYVPqwlhB7O
 52CsHIq0EL2y5ORWjTU8eN2KWambkNOkYezR9mnCF3UewqLMZJ5X9etJbvTKFRKjS4Ff
 LUpFXfYHglLnaBng40Z5EwlnjSBKmEW5mV8+ja9IQqVU87HsyRQ4LbOjG3lU7RhzLdX9
 evGDPLBvQPU6SKZzheM0iV6q9CK5FiyPypHNWfw4CYb5BR0/CYHICY7qVCNqzkijxXmh
 2gsGzRkQHwokVMeb3IPGZI34IbttJo1wEGBh3AYctOa0cH9KZmScOHk33PV+9cf0eOH6
 F8Sw==
X-Gm-Message-State: AOJu0YyT62Y/Hpx9Sfp9ZKMCMjpQRXZJMmZ+82UT96CepzudJnpHz2dO
 iKUUJGSjIELoDFQ8/5QMM5P6MmjD8uHppG2Q7doA954bKfeYctVrZ94rTNue885c+O5EDSys3Tc
 PVBbIP7w=
X-Gm-Gg: AY/fxX5TQDPBq8li/YDN9fV2RuP4O/H19bIxed34mK29Pb6hQeLMBkJAq4maqQfmsLr
 rHkWOE3ModwaIWLdLTyDRZ4DyLI/WKC7xMoCt1eoPR7RyN3UVFPEYSXVngtpI7Grzslpe0RUk7t
 sRhZRy0KfX0ry82BzedcMISguiutim75gHyUVlvTGsphepu2YdjiAIMn+t96BJXOfnimK9fe9vt
 WgWAXDI5PYJgw4pmCBECSJIUA4oiRS64fcLP1HZn9kxO57Wpur5hsbLc/XLWhhLTjIG887Tf2O+
 Du3x7mh+zhPB/98MqEIAnYYY4XO1KcJn7fEsizlYD291WR5/a9lYLfssIJGWzX5skj2RPGmtVpg
 3idbAYLuS6HTJoDhBjN6X8AgZcydyrNrJDQ7VRZ2SeUH8DXI2SCYoSGdau1TePioSNZtAsxnvXD
 X2xyhxLg9JyaTtmEGawHBmIssr8OKc7pqQirWR7F//7KeH6Sy7Rw==
X-Received: by 2002:a05:600c:45c8:b0:477:9a28:b0a4 with SMTP id
 5b1f17b1804b1-47ee3071491mr52506585e9.0.1768431359898; 
 Wed, 14 Jan 2026 14:55:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428af0c7sm12999125e9.4.2026.01.14.14.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:55:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/11] doc: improve contributing documentation clarity and
 style
Date: Wed, 14 Jan 2026 14:54:04 -0800
Message-ID: <20260114225555.127448-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

This patch series improves the readability and consistency of the DPDK
contributing documentation. The changes focus on editorial improvements
without altering any technical content or policies.

Initial work on this was done by the tech writer (Nandini)
but this is follow up using AI to get broader coverage.

The primary improvements across this series include:

- Converting passive voice to active voice for clearer, more direct prose
- Using imperative mood for guidelines and instructions
- Removing redundant phrases ("Please note that", "It is recommended that", etc.)
- Simplifying wordy constructions
- Fixing grammar, punctuation, and typos
- Improving consistency in terminology

The first patch fixes specific issues in the design guide, including
correcting "executive environment" to "execution environment" throughout.
The remaining patches systematically improve each contributing guide
document.

These changes make the documentation more accessible to new contributors
and align with modern technical writing best practices.

Stephen Hemminger (11):
  doc: correct grammar and typos in design guide
  doc: improve ABI policy documentation style
  doc: improve coding style guide readability
  doc: improve documentation guidelines style
  doc: improve Linux uAPI header documentation
  doc: improve new driver guide readability
  doc: improve new library guide style
  doc: improve patch submission guide readability
  doc: improve stable releases documentation
  doc: improve unit test guide readability
  doc: improve vulnerability process documentation

 doc/guides/contributing/abi_policy.rst    | 194 +++++-----
 doc/guides/contributing/coding_style.rst  |  20 +-
 doc/guides/contributing/design.rst        |  71 ++--
 doc/guides/contributing/documentation.rst |   6 +-
 doc/guides/contributing/linux_uapi.rst    |  40 +-
 doc/guides/contributing/new_driver.rst    |  62 ++--
 doc/guides/contributing/new_library.rst   |  20 +-
 doc/guides/contributing/patches.rst       | 434 +++++++++++-----------
 doc/guides/contributing/stable.rst        | 147 +++-----
 doc/guides/contributing/unit_test.rst     | 113 +++---
 doc/guides/contributing/vulnerability.rst | 140 ++++---
 11 files changed, 609 insertions(+), 638 deletions(-)

-- 
2.51.0

