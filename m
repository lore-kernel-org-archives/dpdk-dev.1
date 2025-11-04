Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403E2CCFA07
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 17:00:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 101D7402DD;
	Tue,  4 Nov 2025 18:00:34 +0100 (CET)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by mails.dpdk.org (Postfix) with ESMTP id B2A514028C
 for <dev@dpdk.org>; Tue,  4 Nov 2025 18:00:32 +0100 (CET)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-7815092cd0bso78721097b3.2
 for <dev@dpdk.org>; Tue, 04 Nov 2025 09:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762275632; x=1762880432; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=VEWY8N4YEBcUkN9SIhhxP2NmviutRGIoiNunJQeFz/gPxaIGXnRBkKEodRm8REpFDC
 HVL4SjbIjaQ7YGfKYdHgpoQmOdsHp02DQoYdgzSuC1oT+9LxQ/qx8X1CQXZxz+V8AKdO
 YfEu+mVtMAlNbn6pV99RTongSa8uO0/cdm9b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762275632; x=1762880432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=VqwyNiLSjMEgODDX7mq/VOCvj3vAij3FjsLdqbgKkxE/vFg/JacYq9m7QFssS8sG58
 2p5q3NgXBfQ9yXwct7E+GCOOhkhkC6jVxZkIFCMEpe4w/FA2LKRpyTshFvZHQcNDKnW0
 ww2nP2/TKsmnescZ23Cx1IZs9QHMbCRbtA1x8ti/6UjA0fBpeDNlm8aWPCnvxkf3rC2c
 RH/ReTXEUXL60zFXD74b8FNXAITfpZTTvKApeHlPyXpgyehcHYonod85zfxJU5Z6v7Kg
 WKkWXpx0Q5uCE4Gp72NmyU8l+P0Jlqed3iZ08njUBF6CMELXzhTWasrf5DdKq2SHkzYw
 Se5w==
X-Gm-Message-State: AOJu0YwThcYJYcPAf+3uSLNGd2eeC9lqcKVfsAvdW4oOYxc01sLuPdI8
 B2gk2hfczBuDT16x3VvYjnQWbOFPCfy+mjwUt7PS2c2d7syQon/ssBsor7ry9gG8tlawGcwmc5R
 xwudDUjCUAN+36YG/wSTEzA+tiR+SpRLoq6zxBkehWw==
X-Gm-Gg: ASbGncswmWj2v6w79bRLI00cwbicFl0ZBtKgzetlMPbshauRpk9ys7J8azmS5Z2RPWc
 vVivEvUS0mbyUMGkzXQygIaYa4ccLqti8/qsTY9/0Xm/VKq9JoGNwgc3wgxFGDQ6qim05hNOjkB
 2bbNZy0TrFY71P6JEUYZRSheGsXMwKrH2EWted82DyXfu3YwlJCo3IjpznHD1bIB9sQwumuvkmW
 xfBAibZmiLIySIHvQtR4UG3F2Mxyn4CNVr+3WOPrmdAe3SM/j+E83dX7A0WiAVun4gPDFgPFrw=
X-Google-Smtp-Source: AGHT+IHMa60iLVGSzq99iHkO35YjA9DlffUIPi5J7fgigyrbJ/A+el2Bjhzbkgt/NDHZj5Dhi8K6wIC6+o9hKquW9cI=
X-Received: by 2002:a05:690c:260b:b0:786:6076:e8d6 with SMTP id
 00721157ae682-786a41f9b47mr2922417b3.57.1762275631792; Tue, 04 Nov 2025
 09:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20251030125231.114295-1-paul.szczepanek@arm.com>
In-Reply-To: <20251030125231.114295-1-paul.szczepanek@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 4 Nov 2025 12:00:20 -0500
X-Gm-Features: AWmQ_blKvM7ue6CTbnDiLU6gKmW6cW9YHAE84hhl65fK0PsmF5tQPPyCsH70csU
Message-ID: <CABD7UXMZ-5Mt+TzGOYWaGebBzSFr8P9RjkWDJ2U=7XwQZfBPEQ@mail.gmail.com>
Subject: Re: [PATCH v1] dts: move artifact class to API
To: Paul Szczepanek <paul.szczepanek@arm.com>
Cc: dev@dpdk.org, probb@iol.unh.edu, Luca Vizzarro <luca.vizzarro@arm.com>
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
