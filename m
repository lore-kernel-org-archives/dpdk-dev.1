Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67BEF44872
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 14:37:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F5C5402DB;
	Fri, 10 Apr 2026 16:37:08 +0200 (CEST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id BF4B24026C
 for <dev@dpdk.org>; Fri, 10 Apr 2026 16:37:06 +0200 (CEST)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b9841aecf72so264876166b.2
 for <dev@dpdk.org>; Fri, 10 Apr 2026 07:37:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775831826; cv=none;
 d=google.com; s=arc-20240605;
 b=GEIt1BwDRZp/w6vEOAyFlq17Pe1kcs96jfb2AXhIKrib8rlrcesixyifcdOfMkDzRb
 zTypl9lKKlIPVhDOaD8+IyBF/UpdJeg+xkVBuT4ZTfsNVqr1uPGXfdQ9gvrQw2FSqr52
 XzfLQCj6i05gSN6i2mL+5IjE8rAnBYLgvAqo+o5TzMuxlx7laaRvDczz3f90fY+/HTPK
 pWWi9w4r+VL9+oYbZiMHmvtoTzrTnfWOiTzXcUIvNtDgM9D9i8+nAlAy3hmnJvO5Wk7a
 diTjZNAqmGpKwrWmcvxvAmiwC1r5cw/z7aLxp/0opTMkQVU04QFh5HPA2zTqtgetjYp5
 aanA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IbrGQC6h/iSkOZaeRKdlOJGDMfrzSm1At+gm+E8JJ74=;
 fh=y4Gg3JEPVtLTGlPjWt/fIlgY+JXO6+zjKVsE4FVP7/M=;
 b=jSNqnVbODK35XKUevYW+TUCRu0PBjg2AcfB6KXPj2T7phGF50jHSoxlIRkRTzBa+pe
 5wLcswN4I1PyDsbhHdgU3OKckuOKvma6C4ZF8DEgZSFfxJpOia5+8srrMBL9CQWGgFoD
 6Yh0XZDg4tnfHjaFWX/odLxlIVEy+TK55Sc2CN3OW7E6j5ChJMVWyv7n2LHZQ5+knwPk
 WA9lLjigJiIsCMU7EyxjCfz674aPaMSoUABEjS1+oUvEsrjGJeXjpoPBOn+/FthxjWBc
 g04gN21on0yaz4swswsVdZsJmWQC0o3DGToRNk/KVJRBS4UroY3ohx+7PKp9ue4bxRVw
 FWkg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775831826; x=1776436626; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IbrGQC6h/iSkOZaeRKdlOJGDMfrzSm1At+gm+E8JJ74=;
 b=Tm6DUmX70ctqXZ2zORSlOWadYmnwcxy81Sr10UqBQiYAqM8uuz7v82Lpu9/pjNu+T7
 Z4WyOTUUkJpZC8JpvPFp9wVd3P6CnFx2MpzLp4nyETdip3GQqkl1Ma1fDypkBNKBFF+q
 Na+rnGDa3Qiw2Idi26hIWWIwJ1cD9fGMe8c54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775831826; x=1776436626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbrGQC6h/iSkOZaeRKdlOJGDMfrzSm1At+gm+E8JJ74=;
 b=rID16WLuwnt7MPXm6l6213QtV2gKSZE6qTubkOP77BF0bmGx2oXveb2NkxKjsMVZEZ
 E8sr9m/K9pvFYZZqWJ1jnuTQYIj2T/JzDMDMlqrAWcgqPztTn6nB5qUcMQ9GI7jjLUOj
 5R0N2SvEJVqu/J5CgUSzLNXtB3kUp3Z25Zy1mG5cpcC+0JsFNrjuh0qqGrICtu5+LR8c
 bZEgiYnQBA6cuogfkZeh/qr1kAfqekyg8JF0mXrma3/3nt2WaNNnp+U8IW00lGVcgrcx
 PJOZCPfu1RKvm6JP1GLp8ZEV2v4anGKCjdXQbneU+RZ/UdFvt2wA/UYiP29amW4UmJVA
 9l+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZSnPNxZw3dEHJjUJTtkNUbH3jISkUg7m2LO2fj7uwP5Lb+gFok27cPrQ/6nHfs922dek=@dpdk.org
X-Gm-Message-State: AOJu0YyBjTzd+RtvjPlDhUk+7Sr7bAlif+qQjg/BDgx16mpk31moODdv
 32zO/B6CqGjy+PYLWf6TSE0DqBPgkRHu216q4pkOBwFpWoZ5JfZNiXD4H4xpFIaZilH3ef5w0zQ
 kGCMIYrwaErxyUT28smrb0i/WtCjl3wnLAK3pnH2Yy5FpetxCxaEi
X-Gm-Gg: AeBDieuJ+CObj+a+mbny551RoepyT1Sx0mpusWC/Yz2ZTD15JzdNpBgEfH+uWqLLHFZ
 fh9Lf1xX2hSlkVSYq3q8BeDIDPDxPExlehjI3758PvaGSgGFFoLVRiuebDIYLYXbI9Vmr/5/SAL
 P7LpcCwQc4XPi6AxngXpAgs+HpJgspjMTXUeTkuhAaiJged4Ekcfv8HXJJ/HiowwO6IOdhrvn8j
 0FMFI9rAsIr509LCEurLWgd8cGRqp02miOoWg8lNa0uUMqFJz8zvF5Uv9Jpbu0tfJkxgNshR5ua
 uGHk5PGitC1RKBbPCMrFTD5VXwZswlVfdvJHMBsF
X-Received: by 2002:a17:907:7281:b0:b9c:eede:adba with SMTP id
 a640c23a62f3a-b9d7248aa85mr212283366b.13.1775831826169; Fri, 10 Apr 2026
 07:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260220192510.37163-1-abailey@iol.unh.edu>
 <20260224163200.39360-1-abailey@iol.unh.edu>
 <CAJvnSUCXZhntBmPJYpXobBpCwkBmRWhMPZhH9Sm0W9GiQD_ZVQ@mail.gmail.com>
In-Reply-To: <CAJvnSUCXZhntBmPJYpXobBpCwkBmRWhMPZhH9Sm0W9GiQD_ZVQ@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Fri, 10 Apr 2026 10:36:54 -0400
X-Gm-Features: AQROBzATvwwCaTGwr9cFTQQVuFYv5jscH8SbuiMMA-UfafK9t9evYMWHYMy-lG4
Message-ID: <CABJ3N2XGi3FZpr1RCVVTWCDFJvhGk3VAytbfVVEW_do+qNL9HQ@mail.gmail.com>
Subject: Re: [PATCH v2] dts: add support for no link topology
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000002e1511064f1c1139"
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

--0000000000002e1511064f1c1139
Content-Type: text/plain; charset="UTF-8"

This is an update on the status of this patch.

This patch is awaiting review to be merged.

--0000000000002e1511064f1c1139
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">This is an update on the status of this patch.<br><br><div>This patch is awaiting review to be merged.</div></div>

--0000000000002e1511064f1c1139--
