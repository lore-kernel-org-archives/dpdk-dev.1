Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30550C369CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 01:48:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E555940156;
	Thu, 24 Apr 2025 03:48:38 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 36173400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 03:48:37 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4768f90bf36so5802601cf.0
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745459316; x=1746064116; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tq4j125bUgVq3Up9+ppQP33F3jQzIiyFHvKorMNWi98=;
 b=ThBUsULDBfUg0WvGAb0TuG3G9sLPcHp3tAZl+hd5cI6vlG0gKB9JSDNwylEh3LSs6N
 VtM/+YFzd322SYjhdrc8dOTEw0EDYkhsrjuM2iXt0T2PDVc3Vau+zBo6Iw+DGdmdZGOh
 eNUGoEYLG/iYsXKxtpbqwUIperkuZEi4QpZHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745459316; x=1746064116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tq4j125bUgVq3Up9+ppQP33F3jQzIiyFHvKorMNWi98=;
 b=FjHXmN0L1HBhIPQOFQBmiQMgV2FGMb/ep1E+xDID4pHu3LJGfzS+rNZZXQTWaFRr9e
 QqycMCwLYafr9heyxYKDuT2Qn7Od11Evm0VY1FW9SwkY7SvtTXKaPjvTucmzIliJnuie
 PXnEKfDdNf0veBmSdelTyPIRMDiAKqv4FTLfPNu4l648/VbjyjUB8wgR2nusxl0BszeJ
 mKLkvN4DNB9lTBbf7toJoWvJhd20MJJZ/VjczgexsdMbYErd7uDN4rLqO7anQ9w00FVu
 TvBfws+7nzBvgbdP6mJqgLDKNhGS5oOY7WByqNe7r9bMrfKFpYv4MBuxDbvLhVoP5pLe
 lAwg==
X-Gm-Message-State: AOJu0YzX0chNWLTD5ux4B6KfwXecYheoCK+qsYEFZ4Rd2QmF2IP4PVQj
 KMt8cAi5f/Zd4oqt1GqIolV32kHuPXVWGPMr7NlfBhR9HEiZHfLdWQWipMKiiGs=
X-Gm-Gg: ASbGncvwoJhTbSe/oAmUqD/r9IHoDdtn78/PPNqeuq7UlLLa6ZEbiyUZb3X3XTASdy+
 CvGJlSPO4f8XWNfsKCHAhCWKmZEUSf27Crkf2fMF4G5pkop4eJya1DNu9DHFaC6aR6keZ4qrr3c
 UlHNWvwSbNClMiNfPKhpH4tueiKHcZ4VVxj1oIdP45SgJshXGKysHuFXWFsgDVpST4m+eQPsmUR
 izN1rr5hjUu4DqOXcagpZ28UBrHZKt2Dn30svL9TMWj7uLIZtpupdjTOD1017Oqo6Nne2QmCMKA
 BLHQxeZVZncYZg8N5IDpeCghky1vxrTWwACQR3ggvzsyJskHxFtOORlQ+DZCESmqcMCep4I=
X-Google-Smtp-Source: AGHT+IGGGCdRdxvtZMG/IXf+k5xQ5OdDYSavJdS2R/MU61DcdwBYzT7dvBndtXnY0b9fuoUql/rMQQ==
X-Received: by 2002:a05:622a:13:b0:47a:e616:caba with SMTP id
 d75a77b69052e-47eb29a056cmr10595581cf.14.1745459316424; 
 Wed, 23 Apr 2025 18:48:36 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::224])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ea1ba2868sm4317411cf.74.2025.04.23.18.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:48:35 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, Luca.Vizzarro@arm.com, npratte@iol.unh.edu,
 thomas.wilks@arm.com, dmarx@iol.unh.edu, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 0/2] dts: port over port_control testing suite
Date: Wed, 23 Apr 2025 21:44:10 -0400
Message-ID: <20250424014412.3849896-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20240814182005.12251-1-jspewock@iol.unh.edu>
References: <20240814182005.12251-1-jspewock@iol.unh.edu>
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

This series ports over most of the test coverage provided from the
port_control testing suite in the Old DTS framework. The only
functionality that is missing is testing port functions in a VM through
QEMU and testing the support of resetting ports. Since we have no
method of handling virtual machines in the new framework and have yet
to express interest in adding it, these test cases were omitted from
this suite. Additionally the ability to reset a port is not something
that is supported by all devices and devices do not seem to expose
information regarding whether they support resetting ports through
testpmd.

v2:
 * apply to next-dts

v3
 * rebase on next-dts and minor reworks

Jeremy Spewock (2):
  dts: add method for closing ports to testpmd
  dts: add port control testing suite

 dts/framework/config/conf_yaml_schema.json    |   0
 dts/framework/remote_session/testpmd_shell.py |  18 +++
 dts/tests/TestSuite_port_control.py           | 105 ++++++++++++++++++
 3 files changed, 123 insertions(+)
 delete mode 100644 dts/framework/config/conf_yaml_schema.json
 create mode 100644 dts/tests/TestSuite_port_control.py

-- 
2.48.1

