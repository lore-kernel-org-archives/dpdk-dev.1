Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B8BEB28E9
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 08:23:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10054402B6;
	Fri,  6 Feb 2026 09:23:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DFC194029A
 for <dev@dpdk.org>; Fri,  6 Feb 2026 09:23:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770366209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uon5/UHc0xYPvdDUYVXR2RLT8FJ5PZEX619jxxonDfw=;
 b=YYXRgvpiglzMz4hgqXSPX7mqplhjudRAWzVfUTcWeDcM6ObCmxOwBnhJc91yQdLeiThm1x
 YwscaXuye0oCLr5iLf45s+VJKptoGAPd/uTbSZQiDXXhZ6QDvfERsoQIe568KnUR7TQzC/
 6JuRVkuEw7W1fSIaQUoAJq6VCrTbkrM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-SnDoOTt_O4CSmYVWDn2YFA-1; Fri, 06 Feb 2026 03:23:28 -0500
X-MC-Unique: SnDoOTt_O4CSmYVWDn2YFA-1
X-Mimecast-MFC-AGG-ID: SnDoOTt_O4CSmYVWDn2YFA_1770366206
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3868fbbd895so11956581fa.3
 for <dev@dpdk.org>; Fri, 06 Feb 2026 00:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770366206; x=1770971006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uon5/UHc0xYPvdDUYVXR2RLT8FJ5PZEX619jxxonDfw=;
 b=m2h4VYVe/+tn5ZH62t42bexb6CUwUbmPnOzOoyHsN7WmGos6KruoipYGhy/LWuKqS7
 0Kg3yALlP/t0Gt1PE93pvrtKTVn38+5mP2u9AD77VqmWDQJjkzcxKD7ezeuH9eHgEFv7
 DZg0+PGqhxfx7uSdAL7Cc9DA/XDykWx+PSabLF+1xnlLaHQhNPlaghaGiPUBRKFYM+gP
 Up2b1nOOfhGi04ffG6kY7AqCjEepEjT/2MfWoGLNEbra2DAXdhmD/eggeK0MPZ7O9eTB
 tZHqm6sq3/NXX5Ri9HVHthbuPvtAcBUSkNhsVxAT7HtrMLq2RerPUL1+c1iK+UjYJd8g
 Nn8w==
X-Gm-Message-State: AOJu0YyrFGtp+GAqI0OEkLArHz9iYjpJgSXbJPBwMb486Ib+puRF7TFw
 gMvoOq9pK8XdPLuI10DivRXcqHdLbp9FjVYGrZcajmSVd3Kaa8oCFf+Bt0m/fxqviMLPsHsCJR8
 sisG8VS2A9OoaCo7RepoB+YTP6+1QnUOZzJc5DMfeQIawepBuZ0RQbxI49jLmifCYns8hHNst2R
 ra/d5zlz9VLbitTxN0dAg=
X-Gm-Gg: AZuq6aJX8X6CrwixhtC8OUJ/tWR0dCuCJ6DjiJKKRrYHHdcpKYTgv3viMi6p4jhXxpV
 QCBkjomZifsC11BsbV0dTzoG4WuuPTarWUazaQCj6rThYmg8hF+tpeyEXa4RjG+TjCcmS0coqg1
 S5molQDhkXrLapSEAbOuG+8dInpBjA/Ffll9wF1UmJeUZZVRBdoOHEfdL7VKzAiEdmLG9pFgKBg
 p/8h8gcw0/D0QofblWoF6hjM7gVdTTdoh3SVoUciuIFX6ZtYYDhOY8iXA==
X-Received: by 2002:a2e:a99e:0:b0:37c:c84a:99b9 with SMTP id
 38308e7fff4ca-386b51021c8mr6884841fa.24.1770366206361; 
 Fri, 06 Feb 2026 00:23:26 -0800 (PST)
X-Received: by 2002:a2e:a99e:0:b0:37c:c84a:99b9 with SMTP id
 38308e7fff4ca-386b51021c8mr6884801fa.24.1770366205933; Fri, 06 Feb 2026
 00:23:25 -0800 (PST)
MIME-Version: 1.0
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260205213044.702908-1-thomas@monjalon.net>
 <20260205213044.702908-10-thomas@monjalon.net>
In-Reply-To: <20260205213044.702908-10-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 6 Feb 2026 09:23:14 +0100
X-Gm-Features: AZwV_Qi67iflhqNQHOodpcvL2teQS7Yz5EX8imJgHU9tvsfH3BtFOtBR17qMddA
Message-ID: <CAJFAV8x5s9VVDpO60SJ6VBLPPZEAhDg0UHxkYWH-5Li7m=KWMA@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] ci: fix debug build type
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, stable@dpdk.org, Aaron Conole <aconole@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lCs6u-ypGzF1is1P7v38P13b4u4SSmyPYpYyfXhUZX4_1770366206
X-Mimecast-Originator: redhat.com
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

On Thu, 5 Feb 2026 at 22:31, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> The debug build type was overridden by defining it to
> debugoptimized after debug was chosen based on an environment variable.
>
> Fixes: 918b6674b841 ("build: support Undefined Behavior Sanitizer")
> Cc: stable@dpdk.org
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Ugh.. probably a rebase issue on my side, I kept rebasing the ubsan
branch again and again...

Reviewed-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

