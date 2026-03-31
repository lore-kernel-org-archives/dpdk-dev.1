Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D8F10F9307
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 22:37:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D5D540275;
	Wed,  1 Apr 2026 00:37:08 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 4AFA04026F
 for <dev@dpdk.org>; Wed,  1 Apr 2026 00:37:06 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-82a7ebc729dso2651296b3a.3
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774996625;
 x=1775601425; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qBCA2or+L7XKwjfQVsBbryPeUPzlETd/xHRFpks91w=;
 b=Uyar5PKWfgEJkSlka7RRZ/GWOVOa3HPs1QJt6fuq8AHZT/W3rVKPifxJFI60iA6h90
 OFMmZpymG7bhQg7Syzd7EMs+iDe0i7KWq5LDIJ5qms+tSJ/Wh9IiXE2DKkLcKsIN8zlB
 PJ1MdthV89+9S1vDxMM7LmwXmEKhJhFo436M/dKpKrIHrguTBxYtpHhY9zcUJoKatFbF
 XtFbEyhArlUgTkvLdB3PM+o4onaoCZBF+v7/sXeHT+ry0vhZcWFEbcE+aNWCUgOTAk8z
 joUMrQN90qrK/QSe91gNkfjkuA3Sq+ffqYOgzjvq/xZ9yivw3jPYw+I7QkvNTwZ+Fb7C
 Fxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774996625; x=1775601425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8qBCA2or+L7XKwjfQVsBbryPeUPzlETd/xHRFpks91w=;
 b=kn49Tj8Y0NU4lI+TmOLsl8wKPO3SO/94TDe4SAyFsGF0d/T5bX1fRGguJw5AloQ5tc
 KRBKKMxipld0xDH8xOGy0iKhJbzW1EMMF/y/uJgiPerTen1vtsHk1bsw1lWWXQ/st07p
 qRS5E0ttfb1RS3LGbEixu5UzMtMD+D4i3/3q9VL107stIjXhyjfF3hp62IhDJ1WV46mY
 p1iKkyOCUP4BtyRIG4UP04KDlc5QpHp/+OM9HnrXlvrn6bu6fHaMq+jJD+vyMZNCORgZ
 r5pKUPrxyJhEFAlPVb8fAuNqsdhTIXl8zHRGPpxdIsOyTPReYN2zxVBo0l3CIjK0nI3o
 fEUQ==
X-Gm-Message-State: AOJu0YyFYpUlZr86/vs9K8m2HMJL5Pge33ZqgSkJYgHDeyGfmo8bw4Eh
 WQLyav2w1V1DxGAPWoLDcFp5VmFocl1/RYtAZWFb383+Duchfnj/RP3ZlsIsA1jwnw8=
X-Gm-Gg: ATEYQzxCPUZWMNy/MI4A/RYG5G4MZB7pQjVRMdKKeK8PJtYK5moOCcdinGIeJMzC0gL
 JQDfk8KKZ4lqOBtsvdC19ctOnlrtBfFm7xS5qmxkB3oReO9NfWYgOnwo/WJ/rZQPrR2YJCMkNGw
 MCBdLPRHVhlj3cmVE6b5Ms7fX6m5mdjqQKLTXVutDsy7FKr7dxWyObr7d/MK97rmJFnBK2tETC8
 pPsibR/QAAhoVkuud4sn2Rs2Wmt2nZ1QfKgnZucYDp5NZW+/1CMtXwz5zJcJXmYLIMUEYgBKttx
 DcFnNKBjva5siFU9oCZ343kk/OD+HPrw8iElt2CVej5pKaikJjclv7nCxKpCP+cnGrj8kilsELA
 vLZyaKWZZeFwi2G86tB3v9gTpWI93LNt/iUhn3h5l9ERcUhpqAJ0BHO7Ihmn14zTG0NhRSGpiWM
 dj/16BFfRsV14rIMVqi4vtOTrViyskbrr+pFk=
X-Received: by 2002:a05:6a00:181f:b0:81f:40e5:34c2 with SMTP id
 d2e1a72fcca58-82ce8ac453emr1321359b3a.32.1774996625358; 
 Tue, 31 Mar 2026 15:37:05 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ceb1de4edsm489879b3a.39.2026.03.31.15.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 15:37:05 -0700 (PDT)
Date: Tue, 31 Mar 2026 15:36:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 8/9] doc: reword stack library section in prog guide
Message-ID: <20260331153659.04a35c47@phoenix.local>
In-Reply-To: <20240621023254.4258-8-nandinipersad361@gmail.com>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20240621023254.4258-1-nandinipersad361@gmail.com>
 <20240621023254.4258-8-nandinipersad361@gmail.com>
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

On Thu, 20 Jun 2024 19:32:53 -0700
Nandini Persad <nandinipersad361@gmail.com> wrote:

> Minor changes made to wording of the stack library section in prog guide.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>

Integrated into https://patchwork.dpdk.org/project/dpdk/patch/20260118191323.241013-8-stephen@networkplumber.org/
