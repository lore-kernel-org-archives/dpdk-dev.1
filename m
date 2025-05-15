Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91974C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 19:28:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FCA1410E7;
	Thu, 15 May 2025 21:28:57 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id E1FBD41060
 for <dev@dpdk.org>; Thu, 15 May 2025 21:28:55 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-22fb33898bbso18659965ad.3
 for <dev@dpdk.org>; Thu, 15 May 2025 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747337335; x=1747942135; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8gX7R7CO4YF98TXbt+38/ZTA/A+shg3P+q87IKZucDg=;
 b=bxSI6rDtAbTIoI7+6mkVKOVRnY+hZItwFfZMSMj3u62hUcW1/WyTkpzOwAec8IWypu
 UlmUs9ybwljHQwGqgrDqlJADUuqp6jk8sJvZAn2PE1PhYIxHu3kXwTlHYt769TR0EV1H
 za+WvLOK8nb0GroSZvsnBRKXoQr1cK/ooM5bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747337335; x=1747942135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8gX7R7CO4YF98TXbt+38/ZTA/A+shg3P+q87IKZucDg=;
 b=jwUfaLMDi28Kg9lwCJWWqddXsrcL/d67q2TueazTul5kL+8X4l3s4xYIz7zJl3sMMT
 PqYH9HvXpRf6Js/td2qMeHZ75slLMhrjem7Gys35n2DfOGZH03Tjk4+c8gHk4LruydOS
 DlqeVbLW+32JTFzDgMa15naSeyVrrPauSit0c3U7oC7+BAAw7wNcPMXoh29kUXqXMY/q
 Qdl2wZ0PKsxhQ1v/Sx3Eq7vcLbRdsw/V4mCBTqaSfeqA0t1J/kGT9XaiPg9cANEuYQGH
 yfLN/7PNc9excEoErolJb8LDz3vLWSf1ZpXwhsmzwf2+kHiaRBUx3lwYqgQKI6zEmmaV
 p6AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvvKIvWiWETJAebFzb1al0lMfpAcT7F3c/M21fWMPJSNAf7n45Svauge+n05JpSzZKtN8=@dpdk.org
X-Gm-Message-State: AOJu0Yyak6mhNKu12abSpTD4LBa8M0TbJ4UfxTdYpd9N5aCI5YKZJrzI
 FOuln7LJtGJKaWelhpOQjD6KbbYAxNLaJebd+N+MxM8EulBfmaUWIJN1J25ImayyFtKC9ckgmZQ
 KPz9oYKEnaC2YKA+po5Dqy6T9bQfHq30dCf/1gBCNBg==
X-Gm-Gg: ASbGncu68gnh3H1CSjOfEa71WTNetfT5/tcqf40F/sdsWV67V8U9bMSU5OO5ITkh9Sb
 qw7bU8ZoDglJEM0YvmKVHOlVApYJSYEdanp3rqnYXyEkRITRCvsR0JT9tSqu2hXaolGKQ1TdiX8
 7qRLR54C2NFdYZbZxdxTCvcTtaq/p6IDCYNjGlJO/Drtqm6HoqoEF8a1icEN4I+K2fDQ==
X-Google-Smtp-Source: AGHT+IF2mTdJ4lbZb2rDIXTDXn5uDXHqml6jfisB9QNrxnsmITmTjGUH3YmOj2n4r+z1fpJ2+fc5zYul959lOX6eXNs=
X-Received: by 2002:a17:902:fc86:b0:22e:3eb9:471b with SMTP id
 d9443c01a7336-231d43dada0mr9551085ad.23.1747337335050; Thu, 15 May 2025
 12:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250423194011.1447679-4-npratte@iol.unh.edu>
In-Reply-To: <20250423194011.1447679-4-npratte@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 15 May 2025 15:24:11 -0400
X-Gm-Features: AX0GCFt05A6bA3Rexcz6DZ6jD4unDDs7BJAqCurT9Ug0aN7vVq6uKPXYOxdhHbU
Message-ID: <CAJvnSUCMF3xX8E2TvY9h=eJKa+H1dxdGHeJttAwOWZcGwro6Lw@mail.gmail.com>
Subject: Re: [RFC Patch v1 3/5] dts: add asychronous support to ssh sessions.
To: Nicholas Pratte <npratte@iol.unh.edu>
Cc: ian.stokes@intel.com, yoan.picchi@foss.arm.com, paul.szczepanek@arm.com, 
 Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, luca.vizzarro@arm.com, 
 thomas.wilks@arm.com, dmarx@iol.unh.edu, stephen@networkplumber.org, 
 dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000028a848063531ad64"
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

--00000000000028a848063531ad64
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--00000000000028a848063531ad64
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--00000000000028a848063531ad64--
