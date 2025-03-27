Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D59CC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 08:15:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F9BB40661;
	Thu, 27 Mar 2025 09:15:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 40A2140261
 for <dev@dpdk.org>; Thu, 27 Mar 2025 09:15:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743063312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Mce374Gj8Sm0VyfbBf4x1ytjEE9BkUpDrSIgou5aN0=;
 b=ZjtfsjhoHaICabt1I8C4lEjP1cvRlXdLbEsB7Mn/riWPipeMycgJt5bwWZC+pMz23k+LWF
 EBZF0ItKxYXGvHexOS2Irtwms4+lJchV8k5CxN7ibX50ersKyxCQg1O23/3//4uynJoqe1
 V1DrtHhMSR3wTojkHrj/BC+Y35n71GI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-XfK44NkRNf69xyT32HWvSw-1; Thu, 27 Mar 2025 04:15:11 -0400
X-MC-Unique: XfK44NkRNf69xyT32HWvSw-1
X-Mimecast-MFC-AGG-ID: XfK44NkRNf69xyT32HWvSw_1743063309
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-30db3c4140fso3863631fa.2
 for <dev@dpdk.org>; Thu, 27 Mar 2025 01:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743063309; x=1743668109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Mce374Gj8Sm0VyfbBf4x1ytjEE9BkUpDrSIgou5aN0=;
 b=MEQK/aDcGTcjx/MHCmrYQqpiolR4JG/MLHQpdGsp1fuwgS4KqxniyTFixFCD2hlRt1
 +a3oA7zxVSTcs3gBqjaMWjcV3i8xzRJpsjOIN/7nocS3Ae1dyDQd9QBS+W+e3ZQ8aLC1
 OKnCdFe4YsxlO9CAB//g4IUwjnmicvVvL+uZ8m1o4EBLUfxK8iIVLwGweQmfN5AS08R3
 phpPCcqZQH/Wu7IXE26/3RXQKJO6kP2oWxnaxU2zbzPWvmYE4Bt5BLZnfwSBJHQC7na8
 +tmO5Ay13BRfHk74c8Wz+AILqIJtL7EFMZUm9/q7GHvpk/QgB6IezYaNaw3qq+GcAfUk
 wLDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9i6jaq8apuK6Vvq+oevLoOpTLiGA/53JiKqkKh5Y3BYun+jWhpZlaoqazpBfSgj+uGKQ=@dpdk.org
X-Gm-Message-State: AOJu0YzK+CAKzdpUPO25aU1/dLDrWitw9Y2zxDnGHhcXPAg062dLcFP1
 4z6jn9ifaz+s+Uyr7Y5p2up1Ao3MOA6IrjRe+lMDYmZI5fbjyqiVjyznNkzSgLibvL987NW4Rn4
 SnX+LUNG5kBDIGOq+fJaW3PulKZZl2Kby8zckzn2lZr5prlOe20IffgbDPT8C4w35tfTAsVHzTq
 9MoJo7lHWQFGMAT0Q=
X-Gm-Gg: ASbGncvgrmSXQ6om2H5qACVUocy15QmREM9kL+Oaau/Vr79bHm67BR22TW1wQdJG1uF
 sDhXK9w47miijBSabtYtLcwrpOkcRtEzYhw8E0xPzKw6wopjByHC7rDvFIYVN3uOKAMQ0cf538h
 w=
X-Received: by 2002:a2e:a548:0:b0:30b:ee81:9622 with SMTP id
 38308e7fff4ca-30dc5f45824mr11193041fa.31.1743063309304; 
 Thu, 27 Mar 2025 01:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSwv42oGyJaYuKn/mUYVyFmlW21K3bXusRc727Jrf6C3Z+H/XkzkvqmHEVvs8/1t/WWM+UCE45my0MnNkFltM=
X-Received: by 2002:a2e:a548:0:b0:30b:ee81:9622 with SMTP id
 38308e7fff4ca-30dc5f45824mr11192871fa.31.1743063308894; Thu, 27 Mar 2025
 01:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
 <20250313061904.1466-1-ming.1.yang@nokia-sbell.com>
 <20250313083733.203d132c@hermes.local>
 <9fa6a076-e187-461f-9899-a53e891efb21@nokia-sbell.com>
In-Reply-To: <9fa6a076-e187-461f-9899-a53e891efb21@nokia-sbell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 27 Mar 2025 09:14:57 +0100
X-Gm-Features: AQ5f1Jq-UussPUvXFmy2GM5M7TbeKW9VOK4lKw2SaZ2lL-9lgbxkeA5JLXZe6uM
Message-ID: <CAJFAV8wGCJhHBMTOz0+PYqZRzFRUrO_zy8UzF8s4EVyqG8N=rw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] eal/linux: improve ASLR check
To: Yang Ming <ming.1.yang@nokia-sbell.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pdRYE6f0d97e1W_qOI1LCrpocMeyUgckyYTUOV_38O0_1743063309
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello,

On Thu, Mar 27, 2025 at 9:02=E2=80=AFAM Yang Ming <ming.1.yang@nokia-sbell.=
com> wrote:
> On 2025/3/13 23:37, Stephen Hemminger wrote:
> > On Thu, 13 Mar 2025 14:19:03 +0800
> > Yang Ming <ming.1.yang@nokia-sbell.com> wrote:
> >
> >> This change ensures that the current process is checked for
> >> being run with 'setarch' before verifying the value of
> >> '/proc/sys/kernel/randomize_va_space'. The '-R' or
> >> '--addr-no-randomize' parameter of the 'setarch' command is used
> >> to disable the randomization of the virtual address space.
> >>
> >> Fixes: af75078fece3 ("first public release")
> >> Cc: stable@dpdk.org
> >>
> >> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
> > Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> >
> Hi Experts,
>
> is there any chance to review and accept this patch?

I just merged rc0 which means the patch merging fest is opened.

I put this patch and a few other EAL patches on my rc1 queue, as those
changes don't belong to next-net.

--=20
David Marchand

