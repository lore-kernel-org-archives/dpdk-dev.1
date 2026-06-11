Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350EFCD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 18:04:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0C4543382;
	Thu, 11 Jun 2026 20:04:24 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id C46764337F
 for <dev@dpdk.org>; Thu, 11 Jun 2026 20:04:22 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-307d0405e07so255256eec.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781201062;
 x=1781805862; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDcq9QdxBd9bwgyi2rbbWKB7id59J8/f0OtqC+5TgR8=;
 b=0q7I1ERg/xAPOYkQqLF3eebvMV2hvyxzugGEdtvmY7XNWA7CJBZhtAuv+tPUu48mTB
 UL58OekRvROZdvqT2etvzaB7AAjmZDqZ4HqI6qsPUOmsdAA9zl2caDzkj2kp67LbjHAp
 kPviY7lmbFs0uuVkjk/ixZx8cXL1MuoiP8US3Kid/Ue2RrrIUHNoSJrq0FaHNQst7kVV
 vh4HBF9wE4WeiOSuE+fj6R5X0eFEmHyGGKEZ1pxBFTgKzLtWQ7SRnAZ2pJThbNdAAg1i
 4fuv6yn6WWdpyp3v7XFv4O78f+7TlaE16uJfJulXbWbo5BjGL4dj8tgDOxKbu+wq5ckR
 6blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201062; x=1781805862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cDcq9QdxBd9bwgyi2rbbWKB7id59J8/f0OtqC+5TgR8=;
 b=mstWz/lloEiMNWU8Y1EMx0ysw0kqF1TF8uIG1BX4DfZDlg+iGbGLf3NouLloCVxF8z
 O1Uf0pRjA+ShJ4oobyKsY9pqcBCrtn806Lss16YGuKAFLRpbuC03sMnyrp2/KA9eKqXN
 B1MftZMlCSo6VnaKEaB/8TudbhP7icoTcsuKf0m37Ed1ff8QFj1yQ5GIhncfwJ3mcMb1
 ksR6jsnKHSUiq8oYxE7fjeGs0wWKsCrZMpsfhAQd6xv2CvVOJIlvbjVv9jkYVcF+Sp+z
 p6drMbGgOzLnEBibzoHNaQKj1i3S4XWP3URolSu/es0ZzEOmmJ11rJXVxRp2LV5/mR79
 IQrw==
X-Gm-Message-State: AOJu0YzlzCucqTv5yHkjy+XdBL/UNPD/zq23eztgZNYVexZ2nEXsOVUQ
 XShJNNko3bhRQcQZ3X6PbHhT5vrdFifiWEhMW2TqsZTCPOH2KRL2A8ddlOmp3o9w+VM=
X-Gm-Gg: Acq92OFJxsPSkhPwu8tE5CvIaew3HDEkPns2HNVT7MycRflzamsImpq3VFS1LVVR1EU
 V8aAeLfFqmBD+debN8OTSZ5mZzl6Q1aBUfpqXGOcN3bVaBNpZxG8motQbN0VuqPUZfxxWT5EcLR
 wH60Zd77b4D/zZxSnXqV+bgRLbViGgnVROkgcwW5zU6q+fdCQxepsb0kT/EKXUxzddEXhix2zFe
 gHsP0Kebz+fphCm3/i2CS1qgLX9JuN++h2Op7V31s1fNbkTKlJlDcX5YptYhyl2RF4K5JvBkI5I
 QslrboT2ykVmLxl8kgm+Ep15E53ekG0pqik0xUKHgt/0Dj+1lsopMx6Z6HI8BC3R22T6iICGIck
 5QJm55MFJ77jc89D2MHSlyJIbxhhabh4CKo6fumXaE436aaV+UcdzSWOoQnQwdBko0kp4VPl4R4
 Ev3kKomrdca6hkAdErVguq+km3qjyNWacUUKWAd35rgbq93pRI6/i5TQyVG1VzeRRJRrMlLoazZ
 e0=
X-Received: by 2002:a05:7300:220b:b0:2ed:e14:42e9 with SMTP id
 5a478bee46e88-30804cd0378mr3760362eec.34.1781201061621; 
 Thu, 11 Jun 2026 11:04:21 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806c2f0acsm3853501eec.1.2026.06.11.11.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 11:04:21 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:04:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, stable@dpdk.org, Leon Yu <leon.yu@nebula-matrix.com>, Sam
 Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: fix multicast reception in promiscuous
 mode
Message-ID: <20260611110418.16d5d239@phoenix.local>
In-Reply-To: <20260609075143.32695-2-dimon.zhao@nebula-matrix.com>
References: <20260609075143.32695-1-dimon.zhao@nebula-matrix.com>
 <20260609075143.32695-2-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue,  9 Jun 2026 00:51:43 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> When promiscuous mode is enabled on NBL PMD,
> the hardware does not forward multicast frames to the host,
> causing the driver to fail receiving multicast packets.
> This patch fixes the issue.
> 
> Fixes: 80bd3cad22c8 ("net/nbl: support promiscuous mode")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---
Applied to next-net
