Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62A4C54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 16:56:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3842340612;
	Thu, 22 May 2025 18:56:07 +0200 (CEST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by mails.dpdk.org (Postfix) with ESMTP id 25C1A4025E
 for <dev@dpdk.org>; Thu, 22 May 2025 18:56:05 +0200 (CEST)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-70e1695662eso2067157b3.1
 for <dev@dpdk.org>; Thu, 22 May 2025 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747932964; x=1748537764; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=X7YAGERx/UyZt/+0GQqYgCJBG3I5eStjYwUkeqqqs5tM8HlXS6xvLL4goiOwCYMumX
 TRi0etRJIjaBLCrJbOLtgWRiPd3iTX+Itw+5GMPdupnSv0w6M2P5G7FTSTs/BYRuSf0H
 9U18FOn6EsqvnuMPx7P/ce8zNrL1AZxcLukAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747932964; x=1748537764;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=r2JKNP6rgGtEEIqfcWF4Qh+M0T0FgHxtNNuYXZLl5979DFi80SsVpua26pnubopb5h
 biBoxm86rg3Ljirt1MSFHEeY9HGFGhXqIrS3MP277VLfj38GH/XQ5pVlGZuEvnuFL3hp
 yVdutxDHtdvxDkVPAY/+hyI7RmliurpvLF8sdvCB6qYOpDzfz3amjfB0bAoSLC51DJRz
 CsIz1DhxunoRAZIKHkNxxEVhOcjKmdLBD4LjDIMgb/BYmlLcnzFnv/qnBW5uiEvvPudK
 uDUuBSymce3HrR1wnbkT56va2dnXYSzYpk9sZ8pUt8zxZkzBjRMCBFSbVjjnrHaiVtCq
 VQkg==
X-Gm-Message-State: AOJu0YyY33Kenj+9gfnFU3UxHtaY1XMFRN7d9wWj39AqWzhS6dNGgTbS
 Nwn+LNBGiRkDpCogA7hgVjK1Qm+My+v39Fgh9Oa0oV9MdW+YkrBbgzqwwRO972QpVTvT3gXCZxy
 G1l5X2QYkYLTzZTyxX67DzmDTzPHgNA4lftqItw6e/1KiyqRMoe6K
X-Gm-Gg: ASbGncs44zKSiYMuy/STUZGRNAXUjfiI+wanMuHuSeNrlHHGQrHnBMRphOl9di6th0m
 y+0cblVmoRcq3nDDVauhpaDuwYZsIASjG/3WnldjzCs00MtjlVfczOW9aj/zlKpZumt3bgwtOuM
 1KS1tkRHr9XeZPDP9SmOmtDF/iIlXQA8+fhnHji3tJeXxe4wkCx+eIMgNvbTydBxOHtCE=
X-Google-Smtp-Source: AGHT+IFGtVQZKL5FvDGP0zlLyvJhF4I4W2tzNAT+Lt9kBxZqEF0aruf1fKDay4XQHM1gXjAKH6jB/X8wkDAyJOzjsw4=
X-Received: by 2002:a05:690c:88e:b0:6ef:652b:91cf with SMTP id
 00721157ae682-70ca7c15312mr357091237b3.27.1747932964152; Thu, 22 May 2025
 09:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250516201834.626206-1-npratte@iol.unh.edu>
 <20250516201834.626206-6-npratte@iol.unh.edu>
In-Reply-To: <20250516201834.626206-6-npratte@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 22 May 2025 12:55:52 -0400
X-Gm-Features: AX0GCFsYIi0uQAItC5SMJwz67baMYq-NlXGOp5AdUjSKXlKFWuPovO1nxYhQleA
Message-ID: <CABD7UXMU=2tLdmunVY7KJH+NTChbrZgECt92aZqwztpDhk7kmA@mail.gmail.com>
Subject: Re: [RFC v2 5/6] dts: add trex traffic generator to dts framework
To: dev@dpdk.org
Cc: stephen@networkplumber.org, luca.vizzarro@arm.com, paul.szczepanek@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, 
 thomas.wilks@arm.com, probb@iol.unh.edu
Content-Type: text/plain; charset="UTF-8"
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

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
