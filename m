Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6BBC7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:29:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70540402D2;
	Sun, 29 Jun 2025 19:29:02 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 7E4A140288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:29:00 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-7d3862646eeso86836885a.2
 for <dev@dpdk.org>; Sun, 29 Jun 2025 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751218140;
 x=1751822940; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zot0Hx4IaX4oQZ5X8jQ9LqkkOjH+doTTAjFEv/79OsA=;
 b=g2OQm+hiRpRMSKQL2GNZyQRPlDw+h8VzulKQpRJSF//LH3JGMRwIue8t+G1wqejdz/
 1U85yt/W9sru5/+rksMGo4xfm29vecVuRyPaE/UttRQFGmGBrN2l8So9+a7SAU/9L2M0
 +muJUw85EqRVavtgtjmO9Zm+LYnheiIm+9XX4wgUpm61U1zJhclEdT/TrMV4IzYOrMlm
 1dUmuh+hpmM3PwClP3WaWWJ5a+o6ZcmAUD66UbtFUp6zqG0UPXQ4DKdcRk94A3FtD6oM
 I4G4KD8zjEqKLtbsqj84DGf6xZQIu1IQwQJDtjAwHx1qGq5DmiQM3Q6JgMqTFcMXW/D8
 rpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751218140; x=1751822940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zot0Hx4IaX4oQZ5X8jQ9LqkkOjH+doTTAjFEv/79OsA=;
 b=MaWIKQxAOF754PAbsOQA1FEJ0gvD0/5GfHcx1/Qc7d1ioArAs8WEaW9o5wh3X/DdBF
 di5PTfRsOW1DRn4YEbYiiqIDlnIHY/FXsFLsf7X13XARDGoGgf6W7lajGC5PvirKYJl6
 6HiPwOU1KFWSRwup4VK9HNJ3WblBWVfxioLGCmdpe/ylfVxOLQCipNXiMxMe+rCufTBA
 d31z5Ag3+OYdyM5OLhSNS0LYiwsh00m9p3nLuZkQQa2wdCkaO3CZwTstAe+V0cIBe75h
 UyjPUD/gsbc4bPpz8hW9s3Kl0tUZUHpP5kTQIpmLuj3fuWlOAbcOP2kfdy7nNRFSbX5w
 QVzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3YvfGuGjizGiBaXb1lUXsMP0traZ5DkdcFKzLYv1iuanFoL770qSb3b1qvRbXV3FfOKg=@dpdk.org
X-Gm-Message-State: AOJu0Yyz0xl3Z5scDZxA4byVqN3m4LAoZx1qnVcs06anNQYWWcr7zpxT
 qdFbqWmhV+Rg3ExRN+KPhLW/q6TWF8XOZFnevKgNre9KozPLzJthDzcx4LbMmeNjdiY=
X-Gm-Gg: ASbGncsX0zrZnwm/EIgWL7+XD1axSVKqO9Fio/RrzEBho5FmFcOzaseU9G88NoMcIMO
 eMsDv0zV+HNbKkYbGy5TI+GFgUT9GwllLs1Oe9c7Gb/gJmxbytUq1bASHlenYTX0xmSB7M9FzUT
 qvZuWKKiJDlXp6+9L+KdfmCfxdnmXkVrCtdo3kLRzna5J1z3sM9+L4MrD1WUIeg2HsBXgpRr8w6
 WLb8qpJpFKIiCmit0ZYefftpHCdcuYiZrZDxvZ1nmaffcuw3nmJCVhC7o0eNJSIAUAQHo1gwZLo
 FXEht0i3/i/deJlBzimJAF7LdaStB8mHj3WVoBmexYFDJNjpCVUbVxTDwQN7r9Fy99kW66n6A7l
 wm+BVfRAaLV9Z+F++K+woKL7D8jOFefQobnxQ4Gk=
X-Google-Smtp-Source: AGHT+IE7SScxCYpXuO0kiBIGMqkE/1DlCcGZhVnOetQDrR1a9tARKREUJQwU0WLnQS0y4PUy0AIxqg==
X-Received: by 2002:a05:620a:a50d:b0:7d4:49d4:b908 with SMTP id
 af79cd13be357-7d449d4b94bmr1054991185a.3.1751218139755; 
 Sun, 29 Jun 2025 10:28:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44320323esm458905885a.59.2025.06.29.10.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 10:28:59 -0700 (PDT)
Date: Sun, 29 Jun 2025 10:28:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: longli@microsoft.com, Wei Hu <weh@microsoft.com>, dev@dpdk.org
Subject: Re: [PATCH] net/mana: support MANA in PF mode
Message-ID: <20250629102856.62675a98@hermes.local>
In-Reply-To: <1750895401-5903-1-git-send-email-longli@linuxonhyperv.com>
References: <1750895401-5903-1-git-send-email-longli@linuxonhyperv.com>
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

On Wed, 25 Jun 2025 16:50:01 -0700
longli@linuxonhyperv.com wrote:

> From: Long Li <longli@microsoft.com>
> 
> MANA can operate in both PF and VF mode. In PF mode, the PCI device
> has a different device ID.
> 
> Add this ID to the PCI table for supporting MANA in PF mode.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Patch is next-net
