Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17340CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 04:18:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0521A40264;
	Fri,  7 Nov 2025 05:18:38 +0100 (CET)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 225084013F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 05:18:37 +0100 (CET)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b6271ea3a6fso233407a12.0
 for <dev@dpdk.org>; Thu, 06 Nov 2025 20:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762489116; x=1763093916; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BhHFqcdIjsIRXkDzGTHm8eATjqdXSpVCtqqd9xDS2Po=;
 b=JsCHYQ+ujznkkFHLRdmELwiZjMySai79RrFWL6lrfxxIiZxPh9E5eDZzOu/EMvZ6po
 KL9ShxAFnqycmm95+YqmfR3R9PSE1WGpV7NTrV8MGUL5gwWwtxYIEvoJ+1efbkGkCtI6
 VUvbsDfdHa+ktJUrZ5Z7v2UmIbygE4fTes8+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762489116; x=1763093916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhHFqcdIjsIRXkDzGTHm8eATjqdXSpVCtqqd9xDS2Po=;
 b=LF8U2lC+eL/9Hu8AuxiI/eA4YzbeJUMhWEo9tdEWiNZP5ZH1mvsxj3o/N0SMM2/spV
 VitE1MX00DtSyAGDNZ81b5VC78CpocF8EMCEtejUjl+2s1IqCeTFoDOb+kY+tL7fcwxb
 jiqiOI+WnWtkdx/lBbtdhn8OOuyBvbOI90jMETMAKIzkW19rpXU7/MCS9wStuKJVBrAj
 UGpN1nX4rvgeLxJSWDlPOeXWdlQZ9R6f4QGUdqr0on4vhpBKIcxSAbKn9qhpSgFVM/Ys
 QSbuE78H0mEweYmF+Gqumx49/CWmMlXA5UGqJLsf8uVmdflvQb/+GWHtV6o8A4C5vwQa
 m+Eg==
X-Gm-Message-State: AOJu0YwMVhBCFCE1z+q947HBkOGgDS5JJ4osq4OBAadQivjbmI5ax9bV
 k78RbFwS29sKW1qEXuX9FvQN+5huA63owkV4qmVSSy6J3OQWLJc00BNVfGxsowji9B8S1Ekcj10
 1vfKnmPGFT+bNq6kOqgw3ya0Bp8Nfarrh5cQXbbJfDtfjp2p5dWRBRi8=
X-Gm-Gg: ASbGncv2HSIcrRUpzG5qZpDPHZKTW/NVtR+3z8xAfyE8kJ5fa+pLEwaCb41a6Y6jYVo
 aJvOU4Rhi3pvrTP5V5ACfOqXGz2qcyijpKMTNzWpQAy6GApyLTsHA1wU9AOp41WTiM9djHS8DYs
 i7N9mlWv5C76H23J4/j6W6EH0KJWbIs6iMsmQGlXa+Od/D7jJkiZwXz4JxhHDYa0w9zdD6xTRQK
 LFsFEB1Mm+3dqY4jxzQHeLN8V+LPlH9iUHDJw/hx71ogZ6XazfTyuMTJ28fn1nRPL9pTBgC3qZk
X-Google-Smtp-Source: AGHT+IERqTqG3G2Hh3DBEQwj+SZXhjjImuQ9Ta6j0bzuvaBB/n9hBAGGYxSGJcNDRo8GgljK45XctB3G0VUQSk5AS64=
X-Received: by 2002:a05:6a20:7f88:b0:34e:d23:8627 with SMTP id
 adf61e73a8af0-35225562b1amr2947643637.0.1762489116227; Thu, 06 Nov 2025
 20:18:36 -0800 (PST)
MIME-Version: 1.0
References: <20250730125859.159185-1-thomas.wilks@arm.com>
 <20250910193149.1023435-1-paul.szczepanek@arm.com>
 <20250910193149.1023435-2-paul.szczepanek@arm.com>
In-Reply-To: <20250910193149.1023435-2-paul.szczepanek@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 6 Nov 2025 23:17:27 -0500
X-Gm-Features: AWmQ_bmNzW5eUgYY-8PpKKH1snoconjm0er5q2Hqzrp9N7izmd4p19qSEUTeXvU
Message-ID: <CAJvnSUDVYChRte6CNW87r8rFx=QG_DHRvM69CcXBSEzJoOd-CQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dts: add RSS functions to testpmd
To: Paul Szczepanek <paul.szczepanek@arm.com>
Cc: dev@dpdk.org, Alex Chapman <alex.chapman@arm.com>,
 Thomas Wilks <thomas.wilks@arm.com>, Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="000000000000b1897b0642f979bd"
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

--000000000000b1897b0642f979bd
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000b1897b0642f979bd
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div></div>

--000000000000b1897b0642f979bd--
