Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A459FC982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:55:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8300C42DF0;
	Mon, 21 Sep 2026 17:55:03 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 25FC842D66
 for <dev@dpdk.org>; Mon, 21 Sep 2026 17:55:02 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so2873139a91.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790006101;
 x=1790610901; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ta4fR+5bpt0G/8zMHO6l2lTsXXtBEVra6fERwWoQ6ks=;
 b=BIJwTx+F9Gq6MB7zxKP2WLHpsYvf9NfdOd/kvaazPiyVR5eLLRTqX1lQlXYBkGO8I6
 /7icmq6DOw+g8NueORBgl8C3sd189nxY/D5JW1cFh/kQM0dBQTVfjh1GZ5Eyilo+wzXp
 blBoVbyTIU/LWxQ42Hb3rtmBhqUr8bKD4/45RCmIjpr9d+QH6vcw04+UZ/3xXGc4ajeE
 yK1WscNz+CqzaHywxQQXiyeWDRZLbnheiB7tGpPeJuk3c47cFW57TWCRHEAFfoqPu/zz
 4EY0O5woba5FuxCArnOSFH3i3fDP9eHtdHQUJ7/Jx2WezKMJ/Bis4MO8CeUEvf/OALCV
 uS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006101; x=1790610901;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ta4fR+5bpt0G/8zMHO6l2lTsXXtBEVra6fERwWoQ6ks=;
 b=0PjJhL0Vt0YpX0eFePRPotaYH/Va8FUOocfrMcQZxAYc2jAhUe12I6UTZN2mqbLwjz
 OdPXLlScjHQIfMGsJpqf2wgCIPfnmkDvzQb0cBOxgtSSZNq1k8trTDRHvSKTvwYczINJ
 M0q1bBoqWV22md5amNEJxX0TCkTR1bHLXfCGAqMcM/J2AknETDDcQCk26fhLnDMaYU0X
 TVJeBfSHSSkQnFdjxL7cXX3DnnKuU7XGlMjA7dJkkR+eXwwcWPJ0GHspU603Xz/aJg7x
 mArBR59ebZXMmwNRkhVSvdQwLxx7+dhuAq1EmhavDfwemrhrHVhiok+vQ6/ApObdThx8
 cDuA==
X-Gm-Message-State: AFuF++nyfU8g+PCvfYKpAr0cTHyiCrzJIDzXkg7t4slbF3JhP1xKdmfJ
 4Ic00pdVAHj4RUq0D0EjTDErf+llh42CzTY9tMfpC2cjR8vFVYkW6MDq0DIwjOwlP5U=
X-Gm-Gg: AYBFou2aZpyqWZ0L7xeTQTNJRNz38P308ciPrqk1fvRuuqeReoxs53Bhkb3gjEvWm9F
 arYpLRvVO3y+A4D+Bu/l2VF0v+PqzcAdITgCs2VzOG+cKbd+NrcTrC/fafMeBPw3aV0s8UiDCDI
 V80Vee/D8f05TPUtUxmL4oimXXgli5pVlJZRDpF54LYQxi7V/eggTfyYTkNI9hV/9e5rtxcsNtM
 ZUk1DSzwHssEpAK14ay9hJa69zHcLNlW9tY1C3Gd3hwAyTZLuZFTKKn7WJr+waGVJ8OWJUS4r03
 2o0kHh5QZ05iL16K30uUtO6Ij2XxAGeRTz3LVjErLTLse8GBdR84vkI96SAoELhFMhQ8eMoP0RW
 ictgR4ZCIjghQM/sQYRe574Wm280ZlnlQX8ZfyohaTDlkaceoQRwUg9Qh9QYCx/PO0MRIMfki9b
 K8vILUC5owZX35grfNCEBCRT9CS9KTYZroOYrhwfmrM+8V6sMy9q5MKzZYB1+4lr7UqC199joR4
 UlVi7sKVjtv0q/9RYVqFuH0+8sD1oMGgezw+sna
X-Received: by 2002:a17:90a:d40b:b0:3a0:574f:5854 with SMTP id
 98e67ed59e1d1-3a0574f5cf6mr2410954a91.39.1790006101179; 
 Mon, 21 Sep 2026 08:55:01 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a063c1994esm735465a91.17.2026.09.21.08.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:55:00 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:52:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, Ajit Khaparde
 <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH] net/bnxt: enable Tx completion coalescing in hardware
Message-ID: <20260921085205.5e52f0f9@phoenix.local>
In-Reply-To: <20260921025755.1034702-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260921025755.1034702-1-Mohammad-Shuab.Siddique@broadcom.com>
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

On Sun, 20 Sep 2026 20:57:55 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> 
> P7 devices support Tx completion coalescing in hardware: the driver
> can program the Tx coalescing parameters during Tx ring allocation
> instead of always disabling it. Use the wthresh config option
> provided in ethdev to select the coalescing value for the Tx rings.
> 
> A value of 0 disables the feature. A value of 254 for wthresh is the
> max allowable setting; the driver converts the provided value to the
> nearest power of 2 for the hardware setting (1 rounds up to 2, which
> maps to the same COAL_4 setting as an exact 4; 254 rounds up to 256).
> 
> Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> ---

[PATCH] net/bnxt: enable Tx completion coalescing in hardware

Error: does not apply to main without fuzz (see summary).

Warning: this adds user-visible behaviour keyed off
tx_thresh.wthresh. It needs a doc/guides/nics/bnxt.rst entry and a
release note.
