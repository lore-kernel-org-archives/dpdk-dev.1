Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A0AC19F32
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 03:02:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00E1F402F0;
	Thu,  6 Mar 2025 04:02:45 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 567DE402A0
 for <dev@dpdk.org>; Thu,  6 Mar 2025 04:02:44 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2ff4a4f901fso297984a91.2
 for <dev@dpdk.org>; Wed, 05 Mar 2025 19:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741230163; x=1741834963; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DSM+W7O8zbf6K1VGLpaSoIalS2M8u/p+Lcuoyn2+PIA=;
 b=L5JUGdsy2FzkcJDCr44fJuqRu/+IU0sLbjx1ZWzkZz3+kbCH/MiPXYrSFOh1tajwMm
 4VCF4H6Z1WWMpLHnovt5RyABspVFIHP+1Cnm5yl4iINxo+fMfSDleKAH4gCFtINusaaf
 vE6OuyOUTbVXEATzl4Jt6zTACf59c5ANV80Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741230163; x=1741834963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DSM+W7O8zbf6K1VGLpaSoIalS2M8u/p+Lcuoyn2+PIA=;
 b=cqTB0E6WUvmYN9xgBoaV9Wyz8xbsuUMhm9gzdbSyG4exTn1dw3W+TfzdaJ3Tz2Cior
 aG8zufhYeeoQpnOiXzToBUIldrcNCl8RHpIYqAJb69Q6RIAO8qK6KRfmszSRCnSsDPHz
 pIql9PN0eSvBD83/sOr4oMNe8RbHwoypohol8m2m4UVZkPRKzzskaWP5n2RdmgEj7l9B
 48aabayfmuCv4sGPPnxE/s8bynvVQ+kToeO5lJfhwZzpRCgi7I2yoT0LnXBFQrMrHeq7
 FKCtmPY8nGRUM8Ss+DILXYt9iNHSnFDDMf+Fe5iuCZjzJDIb9C8CzDcYx5ZZzCg1w6kJ
 kfwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj4ODoSSku/+5kChR5Hd8ALiuOUydrB6lBZ5jmWJNvEXD10VEeAnbjU/eyhMGosfChhZg=@dpdk.org
X-Gm-Message-State: AOJu0Yx3LtyJy7IcV3LCHMBFyPs93sKz0ymYfwYKm0sKRTrVnFvtmiqG
 vn/0hEmE/b6hTDnPTwn9m4lbfdP6nSMrHSe+MfewLaRxzgtURjE60wXRuLK/okQxgBhYlQXQlGb
 I6eq5lhfMMNZ5SiAGYKyYzj2d0XxyXFTPb1eFvA==
X-Gm-Gg: ASbGncuETXpOOcF4mcAnIfIcXhesjo1fZRjbhBiOnCGczDbi5KbxqKvk6GBLBU3psem
 LpOC4LT3tbUHQOJJkwptdy0OWk5NRX3ruVT9+pwrxDgDUj48htRC9dBhcCqsO4zm4WTN+39EREF
 BHdYB7TdkdqJliO3Sz1dOWAGrB5lSjS3BlGOLDn30ySA==
X-Google-Smtp-Source: AGHT+IFXk8oKahyHqkiQpXigBFsMM32dI39lsv8oGhO+fmwRNOHxAZs5AKjE7fraWVlRUaVC83JHm14rQ05+8bw+7f0=
X-Received: by 2002:a17:90b:5743:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-2ff4975abecmr8281788a91.5.1741230163391; Wed, 05 Mar 2025
 19:02:43 -0800 (PST)
MIME-Version: 1.0
References: <1741203955-15203-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741203955-15203-1-git-send-email-andremue@linux.microsoft.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 5 Mar 2025 21:59:07 -0500
X-Gm-Features: AQ5f1Jp8bMTf1kQYmNF2yhnzoCaiUR764rvkIGm097Qy1bdAmo870LScN2HDtAY
Message-ID: <CAJvnSUB=CLs6v9QBTsM_xKGLhvxDoEEf_6V4FqFKY79MJk1qnQ@mail.gmail.com>
Subject: Re: [PATCH] hash_multiwriter_autotest: fix printf parameters
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000005c99c0062fa3bd1a"
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

--0000000000005c99c0062fa3bd1a
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

There was an infra failure with the Arm Grace server about 12 hours ago
which caused this failure - sending a retest request.

--0000000000005c99c0062fa3bd1a
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Recheck-request: iol-intel-Performance<br><br></div>There was an infra failure with the Arm Grace server about 12 hours ago which caused this failure - sending a retest request.</div>

--0000000000005c99c0062fa3bd1a--
