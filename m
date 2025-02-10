Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B691C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 19:04:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABD4340611;
	Mon, 10 Feb 2025 20:04:17 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 538AA402ED
 for <dev@dpdk.org>; Mon, 10 Feb 2025 20:04:16 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-21f61b01630so45939105ad.1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 11:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739214255;
 x=1739819055; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=56TT87g+EaONSxuC5XSRpqCJd0qbO25G9j8zmp9hQx4=;
 b=1JeE/P65FfgNL8fjUDaM/9bPotAcpAXpa0L1d1JBX3LSITm3D1MOJDlmOTWCVP0yar
 9dXG084lDJOjPjMD8tlc57nWGhXqDvl364VxNoJygMrFQGHXlKolENq6m5RzuLDumH0i
 X6wyhOnv4bTRD80mD8U9q1UDBGMSmom+mtQMjPB3YKWI0TV244B+OJTDnzYtEE3MWGYD
 /iFQgusU/aYeK66BEH04GwOfYh9R4fyZB4qRJpB42MDLa4y44J/hOsNDNkOhfN/eVOwq
 pzEVAjp8Due+6ZKuyiEniVjY/ESjWK4K8R+el46bdLsq7ZSvpmPWDlWZqGdMzpdwQJNu
 eVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739214255; x=1739819055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=56TT87g+EaONSxuC5XSRpqCJd0qbO25G9j8zmp9hQx4=;
 b=QFbtkUiENFCOgJT/hSiru92JeDVJwlknsfNBmhHQ/k/cj9fivFDCBW6eLg1TESloFx
 EZO8w+LBstGI3e3t03FRhC4/poNTzUR31sV6d7OkiLzfVUmQJPuUvwKNxIPxkPbmWBJj
 Bkc/bmaJO3G5AU1TuZz0HwGjE5WJxyXLcLpxND5nJWnssGkO+J6KgmVOAouhz4cSToS9
 IuumcpIWFZpmyNF5W8r31lhUiK8jKfWK4V2AlIzdRJwnWm8mWG7KMTmM8s6mvGe0afy2
 wjBDp7k3yJnYgFedAwEc4BVbzQqPI7XEw8nsRt74+IqwA4lcGpjFNNjj3VVDPD9ZWWzV
 pi8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM//9NKwYXUAEtgv7NtcNQztHd15QjEVc3fmh5U2w73GIJ5FWjzvOm5ldCQzbNjDqwey0=@dpdk.org
X-Gm-Message-State: AOJu0YysruceWZkPVTKN6H1jRyu3jUGvmj5ayKH3m85uDQ67BASV8oKi
 ILWMBl+v/6DrI+9cyHSlPC5cjoOPoH3gjBxq9fYufuXKJLDvQsmTXoE+R6+YaFI=
X-Gm-Gg: ASbGncutnhQG+FVhtcLQSom/T6lofJwXK8Pak3qMmHiPZUR04xNeGTTYxudT5NJJ6dj
 LhlLvD/il1nI8pnT5MrdBEthmRwwOhYYaKKQCghW8dc99B8f8xm84HiXPPOXcXCKplXBY7v/GDW
 ap8Jp4f3cYUFNOylL8n34Ht8YUYYypF6HPkI7WNWmElvFeQTbT58R/YXgPjeHm1QlJRb2nqOyn7
 Ow/42wRltGy/IZQGzGWa2wwGclGKOqBenamIJRINOnhYi7++LtdwGOIIhGk4FdOpuQM9+CpzYU/
 Sa8M+4qNUxMv8g0FJvYasZy0K8Fa0rRs7vc9s+HM/xpEWWh9LFr4ZAZVpin47ySvz7XQ
X-Google-Smtp-Source: AGHT+IH1rBMOmIYMZsXlNSgWZIp5oycOl8fc4N+RVV7/0p0zwJVE3EhgZlr2ui8uNuN6bJ8LIM6K0g==
X-Received: by 2002:a05:6a21:7896:b0:1e1:ad7:3282 with SMTP id
 adf61e73a8af0-1ee4b5b7e7cmr502667637.7.1739214255515; 
 Mon, 10 Feb 2025 11:04:15 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73077975f05sm4511914b3a.14.2025.02.10.11.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 11:04:15 -0800 (PST)
Date: Mon, 10 Feb 2025 10:34:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v8 06/28] net/rnp: add get device information operation
Message-ID: <20250210103453.010b6ac5@hermes.local>
In-Reply-To: <1739172415-48507-7-git-send-email-caowenbo@mucse.com>
References: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
 <1739172415-48507-7-git-send-email-caowenbo@mucse.com>
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

On Mon, 10 Feb 2025 15:26:33 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> add get device hardware capability function
> ---
>  doc/guides/nics/features/rnp.ini  |   1 +
>  drivers/net/rnp/base/rnp_fw_cmd.c |  20 ++++++
>  drivers/net/rnp/base/rnp_fw_cmd.h |  80 +++++++++++++++++++++
>  drivers/net/rnp/base/rnp_mbx_fw.c |  58 +++++++++++++++
>  drivers/net/rnp/base/rnp_mbx_fw.h |   1 +
>  drivers/net/rnp/rnp.h             |  73 ++++++++++++++++++-
>  drivers/net/rnp/rnp_ethdev.c      | 113 +++++++++++++++++++++++++++++-
>  7 files changed, 344 insertions(+), 2 deletions(-)


Need more here...

### [PATCH] net/rnp: add get device information operation

WARNING:COMMIT_MESSAGE: Missing commit description - Add an appropriate one

ERROR:MISSING_SIGN_OFF: Missing Signed-off-by: line(s)
