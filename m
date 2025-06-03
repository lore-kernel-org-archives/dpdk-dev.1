Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F72CC5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:19:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B658640A89;
	Tue,  3 Jun 2025 16:19:04 +0200 (CEST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by mails.dpdk.org (Postfix) with ESMTP id D10C940A87
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:19:03 +0200 (CEST)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-7086dcab64bso51182517b3.1
 for <dev@dpdk.org>; Tue, 03 Jun 2025 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748960343; x=1749565143; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=hb4PXON9+qSZsuqzf27aoAUWq38ZN6TERXgP0s+CrIthEkXbuPvs1f5frmly0XRdcO
 6vtdtLuoNwbK2OZd91cU8vfiq2RtkYeNhk+gZTVkTL0d91J5NFEi7V1OuWN7COIQQ3dp
 EmSnFY0Nj+hPRCeY3Jw0mxZhdVoVVnQyCqTM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748960343; x=1749565143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=mToukBu/b9MN9VaJD9l3SbAtbHCkqHR86rOM1Jamq9FIIOoPcRQY/rc8CwwKeac6Vc
 gXw5T3oU6//0jRGzluVCOGI3ES7baGuk4tBq73krM0mGJe8fY7GvEcJHOiSLBWRrcWcN
 cG/PICADJZw9oqSwUSwCP5ROi2KiTqTTupzhla2RDrQC6yedgWM5STEPaOiyYU17oEPc
 D/np7MJqD533GGc3bUSjOv8AWm0xIYuyRfsydOsGRxe7BlBDanLlUOxmaSU7QWkR5Jr4
 XSudfB20XkYR1SVnGcXmdNwRNlJtzI4Wl0LPslRxFpEqRLB8vz7Ot/UrpBMrm/Bi+7ei
 5Z9g==
X-Gm-Message-State: AOJu0YzJuXdjm2KMDhK/kyhpsmPZAXHkY+WzLIWZbCkAZ2/aaeJ9iI4o
 Th8OkHnF9TpTHErDnrlrJlX+3h/JsFcAEa+Mq8eWQVhSrqxRq0F0ywGwG2cqkfCoGUvJbtpxX1O
 u6PyeJ9jNfLaaHbR5sEtXFhvjYmIfg/8vJxWfoyDvwQ==
X-Gm-Gg: ASbGncuMbVb/4QnAkvPK9Z5XzzkcAgnX5zf9f8VCbHEwyhqGcB+ZUHGI1lceUshsddZ
 eaPivBIyiTcdqKzzmHMAJld9dN4+mCoxbepgCNo2XUi5vfTlGObpHSwgI7XAGQQ7Yk89wbxTsHJ
 baMPdtvZdc0BN7jIE1b6pdjp+zb+oMzE2Tv+/UaU9I/sXVpJxJMmJJK/wykWuLuRIUneZr5VMJ+
 FryIA==
X-Google-Smtp-Source: AGHT+IEmmtgzhIILyGPcxjBLcFgNAtsj93wxlZsGMsKz4SctBhJ68KsSuyMp5DUFkYV5+rfQxdT8xEtnNsIlUT1WmC0=
X-Received: by 2002:a05:690c:7093:b0:70c:cbef:df24 with SMTP id
 00721157ae682-71097defe9emr170631827b3.18.1748960342975; Tue, 03 Jun 2025
 07:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250331155800.449823-1-thomas.wilks@arm.com>
 <20250506132933.1580584-1-luca.vizzarro@arm.com>
 <20250506132933.1580584-3-luca.vizzarro@arm.com>
In-Reply-To: <20250506132933.1580584-3-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 3 Jun 2025 10:18:52 -0400
X-Gm-Features: AX0GCFvCXhNFSh3TPWWLtQjPl-tQsO20OXFHqtb3NCLUCBooec_GWGSe13ZEuu0
Message-ID: <CABD7UXOzok+NfREqAX2qw5DYJxiS=1JysEci9Vzq-+dsaTCEQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dts: add facility to change file permissions
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
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
