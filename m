Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA10FCCD1AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 17:54:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D7ED40262;
	Wed, 22 Oct 2025 19:54:05 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 4BD6E4025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 19:54:04 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b6cee846998so416533a12.1
 for <dev@dpdk.org>; Wed, 22 Oct 2025 10:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761155643; x=1761760443; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P4PZlXRR8ty+Af0/XurpJP+Dn21AXT2rxAGeqeEfaZI=;
 b=fhVCIfTf+8MJuLpXkYneuI4m8ZnFJXC15LI8LnfXcYoftUCG0ClK1g2yJ1jUB6CaXQ
 cpK8po8z2QZUWgcarSDRdmKC1FrF+KEKbW+HkFWEHP+D0Zaaz5W5uLwhzpGz9GLBlm14
 ggs7nx7zscvz3JdhY2RQyRrOB8uLXXAMmD/aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761155643; x=1761760443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P4PZlXRR8ty+Af0/XurpJP+Dn21AXT2rxAGeqeEfaZI=;
 b=jlU0eEfZezsBBeP9+j1m9oOvLx648735lQhIPurJl+2nLnxtKOQpzdhDbiKnhxv3sS
 At9DhsESMdCi0CubFG2Ad51tsnNOeRY+GHTFWZs7GRAPO6wTTMC7Lopha0EHTEdAWKGX
 w6AJi0Am2CxFcnhhFus6Vu5mkv6pACMKDpqebPwmdGWAD7NZ1Df7oXIY74xfjwuBtRlv
 YBlvXcxtdMij0Fx9rdyi3gwy8uSxU4O8vEnFSkEUVUukZMFA9TzEhiGHz9/v1GzrQ/1+
 uFOfmyfSMIzdk0n6F7Gvt2bx/1xoSRHNqk2fP1o0LTPualLfw82gfBp9jH/5RVLjrTIX
 d+yQ==
X-Gm-Message-State: AOJu0YzvsqqQuoNoFBPKRzOWKJEtJtwDx7Fl4J9n7sN1RUrtZHLPKgsE
 eg92MhRj39Y1wN7NrMzj9t/iytJcM6LqlzVV0llXL6AUG0UDLRqTs2rLEx/YlLxyUXnLGu80BD2
 b+EXIv9NULRokseCMqbvDcmF8Lxgt+8F3Y3on19Zi3g==
X-Gm-Gg: ASbGncuU+jt7108PaDirb+0E5h9KMEpLzAfAS6bJWNoI/dN3iFnDFw6Fw2uIeyJgYdK
 XIMFHKhndVeZOgh+bJejKXJ5FjC7kKOWAt4tRKti10Bq73g6qFZsrb4i+kRCd8Tk/gax9ODu2LH
 Fy7uOTVsRyAiUqINyOHDlxUv269TiZ/N8UcBUgwLkAB5J7O9oZD7FnM5zylQfAFgocQiynDX9CY
 szt5XCmN8lEE+8OUGJDwiCTCL2sqlHiQKZK++z30p5rv+t0guwjbv+QCcShwJFPb1DBcw+cP9Bw
 ct8Cwdfi621pHUe+KC0t4T0C8x2d
X-Google-Smtp-Source: AGHT+IGiLHXxWfcTQlSZuXu4wcQHYXy1yxQwfbd3rUB3igTkMgE1LW87CmDMMvKFc32INIo+J5vkDDo0cxKJUXfR0fc=
X-Received: by 2002:a17:903:94e:b0:27e:dc53:d222 with SMTP id
 d9443c01a7336-290cb278e97mr272817935ad.44.1761155643461; Wed, 22 Oct 2025
 10:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251017121946.421658-2-rjarry@redhat.com>
In-Reply-To: <20251017121946.421658-2-rjarry@redhat.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 22 Oct 2025 13:53:12 -0400
X-Gm-Features: AS18NWCltpezTHP4qX0PSJRWU15LZY4m2_Z78SluwFtK3vaZ9RBVmoXT4yy8jXc
Message-ID: <CAJvnSUB4ed8=z+dcGsowudhodhzevp33KoTLtEfAMvZfm3AQMg@mail.gmail.com>
Subject: Re: [PATCH dpdk] net/tap: fix interrupt callback crash after failed
 start
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000085e4210641c300e9"
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

--00000000000085e4210641c300e9
Content-Type: text/plain; charset="UTF-8"

This email is triggering a rerun of testing at the DPDK Community Lab for
this patchseries.

Recheck-request: iol-intel-Functional

--00000000000085e4210641c300e9
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">This email is triggering a rerun of testing at the DPDK Community Lab for this patchseries.<br><br>Recheck-request: iol-intel-Functional</div>

--00000000000085e4210641c300e9--
