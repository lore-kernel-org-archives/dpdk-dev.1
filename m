Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6A8CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 18:04:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85077402AF;
	Wed,  3 Sep 2025 20:04:33 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 887CF40150
 for <dev@dpdk.org>; Wed,  3 Sep 2025 20:04:31 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4b30f73ca19so1826421cf.0
 for <dev@dpdk.org>; Wed, 03 Sep 2025 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756922671; x=1757527471; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngAPA0OPsJ+nE/6xcogo/BoohOCaPkRy8Fg5+h5m0n8=;
 b=WVBxKDBR3p7CEQ2pZ1bChwPvfKn5E+OkXxtZAtp0XlnMJFXjfT77Ia+hfNnTRb1jei
 YzMZ3imbsIR5Kix0SfqqplHoQkCa98+YphoIG0OrqU70aTKO7IiOhbZYhO5AdI6KUbSr
 WV+SvW2SzaKB7MXMjh9eTJ/Krxm12U5Gb3XiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756922671; x=1757527471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ngAPA0OPsJ+nE/6xcogo/BoohOCaPkRy8Fg5+h5m0n8=;
 b=oNYBflAvPyILBvCnMARp0X9qQgW1TuxkgwDQxhzQ08tbg7GRd1n+H2Fa0yw0LcJNKn
 KoWaEaFPqbbLcKXzbxq6dKsESOATMIJy5JbGst1hvj2bhgCI6DGinPcDVPhg4np8CkWT
 C9P9Yy3NXG5N0Cm4mV60XPLJobdoON23Rz7V907hXMAHqJbUbowYu1MRD1QpoFXpqjnb
 m2lTwQ8Ju4e05vK0joNLOJhiNuZ4tTEqiCAiFYIbLa21PPmjlfHiDsuhDpTWQqzGJEXU
 UF1ndmP8+/B5ASLWzPwXaRL5QfyC9YkRvWdXIuw61oPod7REw/tsfUseqK+49QBkD6JT
 oI1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPPzzrCp2Qm507HQHEODqyZMPH1I69MD5LQva+yLfLGj5UnWzjBcW6C9RcZxvUVg8LBPs=@dpdk.org
X-Gm-Message-State: AOJu0YzueNwcglOBKLoOYHS1O1UiQ5HW4OLNGClONcRT7Vhzcaj0QQ9g
 1s+6F4cwJdg7Ngg9z8agJpbQL7gdwFCYdH33Y4dtDsXZOUiuikB38AdA7uZV36hef+E=
X-Gm-Gg: ASbGncvaQ1c0uAZlLXo0vdc72kvuoRBLqKZDHIHnT/Fx3Lr103B7vE6Xg5i5wdCbYJp
 5Z5k7OYyVAmph36WEKPN+bANZp33XpCHR00Tk+y3qRPuLt55mwDt0oXv+jBBj5q8Du1E2vLt8op
 RigAO8TqLh7C6F71ikcTH6H0oPqQ0PWy4DQJlBsqgmbaCYEvMZeEMgfYGq9Tb7I9GLs+YbHaFDq
 2fFGuybI0789Him7HKKfC8F7MuMO9W6JVYHa3K1E4I80BVXaYS4QsCRiNejqVU7FiFeeBzMnHhO
 KD+Br1dMVR7r3wcs800EaeGTWAN0x++/C1TtqH3TOMR8kKQZilk2KgjccF9DyCd/93GzIJWLmji
 RWgOydlDezXWHULl1jBXTrhPD8gQ1SYt/zjoay2MvvOXlg0vyFAp2xn4=
X-Google-Smtp-Source: AGHT+IESDJ2scibD6Vf/kE885CadejlccOEI3OSgssTVNKpVeij6WL/Cxe6kG+Xq8yJA9HCsZh2RWg==
X-Received: by 2002:a05:622a:5146:b0:4b3:4e8e:9e38 with SMTP id
 d75a77b69052e-4b34e8ea92emr83281621cf.56.1756922670668; 
 Wed, 03 Sep 2025 11:04:30 -0700 (PDT)
Received: from dhcp-10-21-133-214.unh.edu
 ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f62a861sm15073121cf.8.2025.09.03.11.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 11:04:30 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu,
 ivan.malov@arknetworks.am, probb@iol.unh.edu
Subject: [PATCH v2 0/3] dts: add tx_offlaod support in dts
Date: Wed,  3 Sep 2025 14:04:11 -0400
Message-ID: <20250903180414.83001-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902142725.56736-1-abailey@iol.unh.edu>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
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

This patchset introduces the support for Tx offload configuration
through DTS, allowing test cases to be written utilizing Tx offload
capabilities. Along with configuring these capabilities, they are also
added to the NIC capabilities class, in which they can be required by
test suites. Finally, a test suite was created using the aforementioned
changes to update the Rx\Tx offload test suite in legacy DTS.

---
v2:
* Removed mentions of mbuf_fast_free being configured for Rx queues/ports
  as this is not accurate behaviour.
* Clarify argument descriptions in docstrings.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>

Andrew Bailey (3):
  dts: allow mbuf_fast_free to be set with testpmd shell
  dts: add TX offload capabilities to NIC capabilities
  dts: update tx_offload test from old dts

 dts/framework/remote_session/testpmd_shell.py | 333 +++++++++++++++++-
 dts/tests/TestSuite_rxtx_offload.py           | 150 ++++++++
 2 files changed, 482 insertions(+), 1 deletion(-)
 create mode 100644 dts/tests/TestSuite_rxtx_offload.py

--
2.50.1

