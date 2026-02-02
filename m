Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AE7E7FDC0
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 20:17:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7C644027D;
	Mon,  2 Feb 2026 21:17:49 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id B244E4026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 21:17:48 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48069a48629so50537885e9.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 12:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770063468;
 x=1770668268; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRuSb9Q8bBDOeQH1Pv/kVeEinxxqwPoKYMr73HJef0E=;
 b=AyXy+xpqrEi/VRUs7ohw9VZ6WoNMQJN4Z35Qwj9DOG9a3xjcxsls73URxpQpcsrzhL
 wNsc4qY2MSqqkZicBrezFcJ2b/HP079yJkzq52m+yjTjWuBC51snwshmjl8lurwiXfaT
 PfQN9IoEwmMx4APNl7Z3eA3olZxTA42QsrxTETi78RKaNcGapK7BHUZxUi7Fa5t/gMJQ
 a7Ar2IrOlM78veeQznC9eOxfvSfnkcj4KBq0wsrlr2XYKetJHPkz8IQCphz0aeNzJW5I
 cX4opaZRns4AtdoPL6dPxkkPfIRWL5k/7Knhiuac1HrXw7m4UX86RYzZLu1EZOqs16nz
 nt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770063468; x=1770668268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yRuSb9Q8bBDOeQH1Pv/kVeEinxxqwPoKYMr73HJef0E=;
 b=G0Zscr1wjHmDgpoJHORViKzI/A6UlZ5fnWQwGDBbn18uSymd8K+vrZH8ynr6bbzzNx
 6U5ZBN7JKhjkVIFqJz1um3T5MXFeyQyWn9S2Gx6Z02Mrbn09PcFLbbI52HGA3kEp78i8
 RXNDp/5A8/m1JSPdsxLzr8lh1Y5iyh3Wty1lyVirpaU1KrNg1q7gjOvEnud4aPwIq92b
 YDLHzOlmPqSeuI7q5QG2FBw42AtET6EArOzKsjMjb7PEBtbmfn86Jhz2osmavWzEiccE
 x1GUMpNIJsI8VDh59xMBAVJBm+O5Yt4HCX5TFlZ52oNywVwbU3y2wT+unIAHEviMyakA
 m0/Q==
X-Gm-Message-State: AOJu0Yx+7ZYcicnRQfyoOgwZVqFg4G3fr9KJI33vFaf+ERAT6ys1TpbF
 NQf1dkIsPpu6kjLRf4qZneaPs52YJTHaji4qjYGZJX//A6DbvGrRIym8JHgdj2/4BWQiJQTmwDU
 v8tZ7
X-Gm-Gg: AZuq6aL7f82NDDcb1mpRvMlLv5vIIW9HdACW6raR71fhnTS/q0Ejz/NFhJabS1ZbmRv
 H3a0Q5vBgi4f9YrtQKJS1TykFO9sCAugKba3SLdUE7+Uw8ecD3nNbbFDpD0cMaEOd0XUO9Q6G45
 6XDtzWVHHG/bgCgi2EA1tmUcgf881IWhNo6DMHDcP5rrtpPybPe4St4LrUuuLXXGl9wZwuo+K/I
 Mm22fqhSFNzW3J4Qk8wCxDloQmsPUostsw5WaFHJit422z/pxINmlRncnnvSOoVPMbn6ghRZ01E
 5aEc/ODEVHWFb2PsiDj41ghpL7rqI8jgV4aZHeAv266KUVMvp6gm5AlXOVeYqO0C8IfzjnkZE5S
 yn3AA0HevuAOxlpyHKBg7co5Qh+XROXZ5r9FH493E+0HvnykFiR4tE8OxSLOLTvpEVBtHcMabMT
 ngIAp+IBFXVwRnRD0NY7lzv+1s3At3xDMxoiildbgfLncfaxEIHTWF
X-Received: by 2002:a05:600c:c16d:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-482db44d22dmr183407625e9.6.1770063468139; 
 Mon, 02 Feb 2026 12:17:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dbcf9c3fsm118018415e9.4.2026.02.02.12.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 12:17:47 -0800 (PST)
Date: Mon, 2 Feb 2026 12:17:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Martin =?UTF-8?B?xaBwaW5sZXI=?= <spinler@cesnet.cz>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] doc/nfb: update release notes for nfb driver
Message-ID: <20260202121743.53ad004e@phoenix.local>
In-Reply-To: <811bfe37111be369a9aba35c49d705fd74f4ea54.camel@cesnet.cz>
References: <20260202151521.3245438-1-spinler@cesnet.cz>
 <20260202201207.3326331-1-spinler@cesnet.cz>
 <811bfe37111be369a9aba35c49d705fd74f4ea54.camel@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 02 Feb 2026 21:14:58 +0100
Martin =C5=A0pinler <spinler@cesnet.cz> wrote:

> On Mon, 2026-02-02 at 21:12 +0100, spinler@cesnet.cz wrote:
> > Update the release notes for the NFB driver
> > with the timestamp value changes. =20
>=20
> This release notes update should have been in series-37064 ("net/nfb:
> code cleanup").
> (And certainly not in "net/nfb: rework to real multiport" series, as
> you pointed right).
>=20
> But as the "net/nfb: code cleanup" was already nearly upstreamed, I
> didn't dare to modify them with this patch.

No worries. As long as the total version has the right release notes.
I don't worry too much about getting the release note exactly matched
with the patch.
