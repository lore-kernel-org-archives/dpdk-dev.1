Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C97AC5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 18:41:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C5AD40150;
	Thu,  5 Jun 2025 20:41:49 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id EC247400EF
 for <dev@dpdk.org>; Thu,  5 Jun 2025 20:41:46 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7d098f7bd77so149500585a.0
 for <dev@dpdk.org>; Thu, 05 Jun 2025 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1749148906; x=1749753706; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=akJteZS8N0HVEWgX7L+hEw5/WIkL9xcRvf9pPbcSEB0=;
 b=UKeK2oJrk1y/h4FWp3epra7l4wI3F4YhK1EsgPYWlHiUUkV5c474Lqv8xeU5PuyTVD
 8Q8TODxZ0KmURmoLC/yqKN4Kgt+SKZ31o+WEoMHNjK96sgUGLaMdbs5d9BJwW6JMEMNs
 ERoql19Nm+w1gL9+bZWxbc4AezAj8zfEICyxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749148906; x=1749753706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=akJteZS8N0HVEWgX7L+hEw5/WIkL9xcRvf9pPbcSEB0=;
 b=Vaerk59RKn5Ervt7Zdsog0rd42VWPlM6wbDYL8Pao/T93sOmqZuhP9xZjoD765JqVm
 ndscS4CiaS6OG/UPzshpYKpHrQI+oGkrgEF3FIUevL4XcZ5rJs9fz/7NCZm5zfmhQVNf
 XvXVhW5MXPjopH58KE0TLFstyPSD44TEbuAwvVpuyas92tC2gcK/dDdFqJUelEn5ygVy
 dFAKeEojqori594Mgq9fVTNWL3E+EuKvDt9SzFfKR1UXfHW6TzUC2V8ZG+OsDMJGq45y
 jaIs880W5Dxysfvob15yyzZbh0CydsDxQEgADC4RF+1mgdK5ixuVTGTy+Pjxd5NIOK1E
 7VZA==
X-Gm-Message-State: AOJu0YyrMxI6ym8ghaQpyCuHTzsQhTc/AeOpa7aQM7UwEMm4IHpdZV8R
 3wzhpGEb15nlKCY4dGOodKxrBuq+JG+ZCSn2HSEnVWBw6wtzw3bfHLjnLr65pq7ZCuE=
X-Gm-Gg: ASbGncvKe/gE2kQQLX/C+pItBkybI/xaZYQcj9GPhUsLx1RhgEZ6vLDT0sYCCVzavGR
 ZPXDV+bU8i6zi9HmYiBzvG3ILKoDtmDkVb5zLpmAoLA+rnqKR7GXj8K0+ouJ0Lf+2ivMuCUK0r+
 F48BMpNVk2DiSpOhVHzHPDbLfmN2dE1ACUQeHlWtJ5d9Po6p8RJjc0S7svCqQPPvvRCnk+76EsA
 TsP1ehJEndMXi8k5ga27VkoJ5pWjEG5k1I+BeDnfbWPocp0PIaLzpYMNk+eHy4EUEfTdr4SYeA4
 hlrYeUAAnLj3hbXFwXUe4QFUkhH8KWWvGwFjlA6covhDk1P0b6C5vg==
X-Google-Smtp-Source: AGHT+IFLE9pfeJznNWZvqzvkONK4oLv/+OzX69vupgA5lBoN+MSRXwK6Nh4o+qd5DpjwUkbB344EFg==
X-Received: by 2002:a05:620a:4055:b0:7c5:95e6:62c9 with SMTP id
 af79cd13be357-7d22bfbe445mr38452285a.29.1749148906241; 
 Thu, 05 Jun 2025 11:41:46 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d250f64b8bsm3865385a.8.2025.06.05.11.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 11:41:45 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [RFC PATCH 0/2] add qinq test suite
Date: Thu,  5 Jun 2025 14:41:41 -0400
Message-ID: <20250605184143.498892-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
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

Hi all,

This patch series introduces a new functional test suite for
verifying QinQ (802.1ad) behavior across Poll Mode Drivers in DPDK.
While existing VLAN test coverage in DTS
includes basic single VLAN and dual VLAN tagging scenarios, 
it does not specifically validate QinQ encapsulation,
which is a distinct Ethernet frame format involving an
outer S-VLAN (Service VLAN) and an inner C-VLAN (Customer VLAN) tag.
This test suite focuses on validating both the software classification
and hardware offload capabilities provided by PMDs
for QinQ-tagged frames. The suite includes tests for:

QinQ Rx Parse - Ensures that double-tagged frames are correctly 
  classified with appropriate offload flags.
QinQ Strip - Verifies QinQ hardware stripping functionality,
  including correct VLAN Tag Control Information (TCI) handling.
QinQ Filter - Tests packet filtering logic based on S-VLAN ID.
QinQ Forwarding - Confirms both VLAN tags are preserved across 
  forwarding paths.
Mismatched TPID Handling - Tests behavior when the outer VLAN uses
  a non-standard TPID, ensuring proper fallback behavior.

Dean Marx (2):
  dts: add qinq strip and VLAN extend to testpmd shell
  dts: add qinq test suite

 dts/framework/remote_session/testpmd_shell.py |  52 ++++
 dts/tests/TestSuite_qinq.py                   | 234 ++++++++++++++++++
 2 files changed, 286 insertions(+)
 create mode 100644 dts/tests/TestSuite_qinq.py

-- 
2.49.0

