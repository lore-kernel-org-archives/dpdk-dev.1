Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9022C83F26
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Jul 2025 05:49:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F0E740DCB;
	Thu, 24 Jul 2025 07:49:26 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id F2D8140279
 for <dev@dpdk.org>; Thu, 24 Jul 2025 07:49:24 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-748fe69a7baso576330b3a.3
 for <dev@dpdk.org>; Wed, 23 Jul 2025 22:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753336164;
 x=1753940964; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5qXZwlvBwpNIXTaaNF5uBTc4ByGFQf9nI1coTRXrOM=;
 b=P80Iro2hCBT+/VNKYPr+Z8pVM6SjDn0ghfIZcHHuFV1ha0rooTrvjXG5qou0CQFWi8
 1yQCwAt6VoIKXIcrek3V/1Gown6BOk4OZQW3EuFAnt1SZ8fT1Hmp48mLUWmzeQBP5v0o
 20+zWQsRvI8JIFw7pLYE1/U4E1tdxrXgvYNIf5PYxr8eDjztsT6vglZHCtqNzOV+fpZk
 2oh3F7o/888pMgXzDATEJg+xRVNbv4Nsm2d+tBEQiRom6hkYp09FR4bKiFYPxcXQX470
 Jz5HHhhg8/bpXl5dUz4tSUvI3mifnSL2eUvqZbnUZjmmqgI3ioHkB7JifjTqQdD79mKP
 KysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753336164; x=1753940964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5qXZwlvBwpNIXTaaNF5uBTc4ByGFQf9nI1coTRXrOM=;
 b=M3TNgmFo8+JZhPcNY7VG40FFArGkMjTyaWKn2SLYrYYatTQb2SIl2YehUIFRC0U0vg
 7XiLjGmTT23wIQZmFfewdX4X6JpCgu5I6Y+ALVmEfmmigbwvSI6z+OJMqCykJu47aaIC
 TQ0p7tDTS8JRVEXZDkbrFwGDl9eNVn9yfqSGuxtovOuNyHhJZFfoiws/S1nc6wclOxls
 nvfSNrD8QFgMKPhtFaLpnmEb+mdpjmoOLXa6HplEW7ZuFXH+YAofkX6CNfX+ZKM1Uru/
 OkImazziCXJEs4pVSvPcrgAqF5RkHdzUUmasRMnFgclsSlm5hpB2rBoWuZcxgdIYqj8n
 5sYw==
X-Gm-Message-State: AOJu0YxB6E+Es+sAuUmsdiNc+ecBP1B2oEpNRz+KPMAyAKZLIqQwpF/s
 sf24zPPmgMgY06+4xjR56VWcOAbwlR31WKg5ms3r9LXMM5nlP+UViO8XdBy09pO/GK0=
X-Gm-Gg: ASbGncvXWY1Xn61Z8dyH875F/GpPLV12dnIIerWL0MAAOFxmq6c3CXRPN1JLYEvxi9d
 Msc3FuhFBlYNbuLmEk12icPaO6rxUWx120nmiF1ZUL620/0McMYA9CmraX14crC4ukF6EVyp9+f
 N4PmHWZcJ6xGWvxYe1kQRHxqPogrwk9O1yCjTGvhqNmnuMvXgBf/vVP98L339Ld5XqThB3BESWR
 MIGDSJgX12VN+bTmIqIrm9n4BcvEAZ4FExyCOaIH8P/x8qNkir1lM3+pTWZo+VRgMbaa6LIDF/e
 ecnahzBXsMD0Phb436dIYzPfojy+QMCqprCX9k+RBOFEHvO2sp0WOFgrS655jhO8kHBkpewp7y5
 7esNFm7xuCPwNmOQB+d05I1mnIOLGHSUolMH+55Qyfs746Dgx
X-Google-Smtp-Source: AGHT+IGhR1s4PMljGUcH+q0WekXTDscNIrDRTzRllDOoRLXO5g2piS185+e5iyn/srlNWlNNkneI1A==
X-Received: by 2002:a05:6300:6713:b0:22b:f4e5:d0ee with SMTP id
 adf61e73a8af0-23d4902d89amr10248864637.14.1753336163830; 
 Wed, 23 Jul 2025 22:49:23 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761ae158d40sm763446b3a.52.2025.07.23.22.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 22:49:23 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org,
	stable@dpdk.org
Subject: Re: [PATCH] [PATCH v3] lib/ethdev: fix segfault in secondary process
 by validating dev_private pointer
Date: Thu, 24 Jul 2025 01:49:03 -0400
Message-ID: <20250724054903.1923586-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723072216.5a34b44a@hermes.local>
References: <20250723072216.5a34b44a@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Stephen,

Thanks for the feedback.

This patch doesn’t monitor the primary process, it only adds basic checks to prevent crashes when the secondary 
process calls certain APIs after the primary has exited. Right now, I think, only specific apps like `dumpcap` 
use `enable_primary_monitor`, but most (like `testpmd`) don’t monitor the primary at all.

I understand your point about improving the whole primary-secondary monitoring system using a better method
 like Unix domain sockets instead of lock files. That would definitely be a cleaner and more reliable solution, 
and I’d be glad to help with that in future work.

However, even with better monitoring, we would still need the checks in this patch. They’re basic safety checks 
that help avoid crashes in any case, for example, when the API is called with null or invalid data. So I see 
this patch as a necessary short-term fix that doesn’t replace, but supports, any long-term redesign.

Best regards,
Khadem

