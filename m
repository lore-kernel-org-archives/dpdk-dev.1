Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A47C56205
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:20:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EDF34027E;
	Thu,  6 Aug 2026 19:20:19 +0200 (CEST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id C1F2A40262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:20:17 +0200 (CEST)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6983d3dae7aso1855797a12.0
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786036817; cv=none;
 d=google.com; s=arc-20260327;
 b=hIK2H33y8L2dBIXGA8avQmnPEyhKfiIo1Bxpr/4Q3xWSxSGjUMR7PKyJeD3wEOWI/I
 7JQiMaugQanmKpI3MWU2svjiv+29KX8TsfLNAwRbr70iDqpDYukbQaNAS1vJbzL5DYQK
 yOC+bsfP++PdoaY9pRVqY4RnUxLLnru4L5DqpVrKShtvJXCFLviRb9JEziGnY9bbO5cy
 ikWOcXc1TKPhh+U7LG4K3KtpsIdL5wU8Kn0MzJe4XOlqbxiE58BFHQljFbKZtweTSccV
 +RJutvwAjFPqe52ZKsHHbkoEQ78AlUrl8xI9FSJ8r8yijEkdG5I7vPMw9LuKNZPCp9bj
 1JeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N+harJlZ8sC7uYASR3sIXfOunSQCetOFnxe1LjpsUII=;
 fh=lvQ5ovoTgObWsTRkBNft/wY2ueCg23Z0yNLvxWYVZ5o=;
 b=gceu4keo+C31/TflJ000u+kvFgVZOW4UsBWxIQaevijUgVt9GpN12DEHGzeOgh9KNZ
 A2vdQc+B8GRvK/9zo1sQtkLSvCSlzXHo/NEvpQcDpbi9DESXiN3FsVwQ04w/Dqz3w/nV
 tUuXXG3eSXXOpaR5rs+j9qA2WPdQZ59cfqQayglkS4MEN5qCHWhJn5xTs9JncoTN/QTJ
 g7HMTMkXoVvA5wo3ICSZBc62J7RjHYwcphAVBLrjhgs5+/iVFh0wr/hEeuMHfkrS92Cg
 tr7YlThKeh2uPr6zlPO5FaFSaogsHgxK7EcEtzX8EPeWXXtz2B94UYLY0E5xqg0uTF78
 2RfQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036817; x=1786641617; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N+harJlZ8sC7uYASR3sIXfOunSQCetOFnxe1LjpsUII=;
 b=S+EnLSu755s6rLeJ56hXnd/zqaqg+oZlhAXe71VcrKoJ/+M1meDQsSx8IBePREzrHI
 txEjeHR4HvpbsVutRSE4xy/0HpHNKd5zvuKJveM//ytzPwXzD9EHD7JPvNNr7n8PPKM3
 C6g12+zvhjrVKnc49WYue3x3sigJhI1d6krJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036817; x=1786641617;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N+harJlZ8sC7uYASR3sIXfOunSQCetOFnxe1LjpsUII=;
 b=LXRp2Bjb8WvrqzImEdLaRxNka0X7PtflLcHc4t+H5Dwr2MwYsxWKNc9YO5rvbwEU/I
 0MA7Xm/xoQ+FnvshFrPQVv5Wuxrm8YmKpHOgBKZW9moDST93zCUESaF9t/3zWnYKESHM
 9fTl49nnw7bKeXnsM13SNWBBLYVpru4v+1dkUBXK7VuMhhT5ARs5G8eGaHMA5qoT+w38
 63ILwxOlpYWHf1ZR+NmlakxH5O7IHoflW9ASndyCmhrmtmSmPGaWpWW2HoSW4z1wz+0F
 SAijCeCt0bAvfAwlcYdU/UKQ0libCNFzC26WeMLZQP9Ki/aKwAoE2YQriW5EbwVDmZTe
 GVvg==
X-Gm-Message-State: AOJu0Ywa5Sdz6fdpnibOED5JdiRR2u0QHqaaW8r1bMl2zOJC6e7uyLif
 TTm13DP6tr8d8J5cuHnw2S9xai6tlmsVJe31Hqozmq/+LrfJ9YbgvX/cz7cQBSEmsoI5WqN3Cse
 Ujea7slXnBn3Hf7Sr4XDIazZSaBGgIz+yza69wLzZIrstScl9G7e4zjs=
X-Gm-Gg: AR+sD10BqAHglz88GFArWxk6+uX7hFEQ7Q5iqnkqniwByh6g39aLt2NXHlxVjwCOX6o
 foMIo2GVLxHOp5S9CKz50IWvo0oieJ61/Ec17iCpH+vK0w/yk6cbg5/yNx6xIaa0Kzu3HdphEgZ
 k/rMUEBMpKDYpH0rheuTA41bVx7tdqKZ8mgof5/NVHNVgrYv74u86ZHhZvaDi1ORt9nNMS7iIwI
 1Nk4bZdy19s0ywYWyHhLuFfM/3qjuCVzJ9fxaobUEZJZFVn1NQCRijnugp2WfRyZNh9OYhAjKYj
 zKhmdl871KRCTiCF43CXg2cb21l92xzeN8lJLOwx2Mghg0FFNKUV7sB3bGga
X-Received: by 2002:a17:907:a606:b0:c1f:df40:1d83 with SMTP id
 a640c23a62f3a-c2057e093demr465781766b.5.1786036817462; Thu, 06 Aug 2026
 10:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806171636.656181-1-abailey@iol.unh.edu>
 <20260806171636.656181-4-abailey@iol.unh.edu>
In-Reply-To: <20260806171636.656181-4-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 6 Aug 2026 13:20:06 -0400
X-Gm-Features: AUfX_mxu9x5CSN-21czLdteowzhgRiclI3m7VphpsI1j9GNyR9EDjNDnWxJGeYs
Message-ID: <CABJ3N2VS5ULK3xSj4PPio9hoY=auAjyL15eLkCLbkSVpgZTFcw@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] version: 26.11.0-rc0
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu, 
 David Marchand <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>
Content-Type: multipart/alternative; boundary="0000000000000f98940658641a2b"
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

--0000000000000f98940658641a2b
Content-Type: text/plain; charset="UTF-8"

Hi all,

I sent the wrong patchfiles out, please ignore.

Thanks,
Andrew Bailey

--0000000000000f98940658641a2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>I sent the wrong patchfiles=C2=A0out, pleas=
e ignore.<br><br>Thanks,<br>Andrew Bailey</div>

--0000000000000f98940658641a2b--
