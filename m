Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A50FC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 13:54:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2090A40E0C;
	Tue,  4 Feb 2025 14:54:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 44DF540265
 for <dev@dpdk.org>; Tue,  4 Feb 2025 14:54:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738677287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JqxAosr17s9yU38rzoMPJDunzQOevCHELzuOyZU5Dog=;
 b=JNaFA9LLf+gMazdCYXqhGWGxwCn2u+ATCebl4ddQcm67wsrrkrhQs6vmRZ+5AA5UQKD7XN
 p2DzrmD+Vg92Tb5q1ZH64PRmZQlL2xfKpmLegIDGE1fzRfFwOt7I24jPpvLbaPRdVCc/uK
 1gh6u8okLiCBCxlInwocxcqxoZqKVuc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-MO0LG1HiMrGWc01YK-enfw-1; Tue, 04 Feb 2025 08:54:44 -0500
X-MC-Unique: MO0LG1HiMrGWc01YK-enfw-1
X-Mimecast-MFC-AGG-ID: MO0LG1HiMrGWc01YK-enfw
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3021e171631so28178531fa.0
 for <dev@dpdk.org>; Tue, 04 Feb 2025 05:54:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738677283; x=1739282083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JqxAosr17s9yU38rzoMPJDunzQOevCHELzuOyZU5Dog=;
 b=s6v3on8G185kaEFUYj4IyyzwmFq+kzd3TWA8GNdjLc7O5HnHjSWFTBdn8aSj9l8jcc
 TBuwWHygUDSpXcLTPUoD+Py8D+BfS7RlN9ls62DypmSae4SzbagfbHvCAg+hcjB/ljK/
 ydk5d8apQtVhPls0rUQnQ4yHe/+v6F863g0er5NFviPin0kqokle17PZoAnFKkJ5ZXIr
 6BATQ8gl1NG9DtYraZswM7fKExUnbcT2iWU97x2U1Dm3Na2j3u9QCprQhhSiYVD5U7Rd
 fuiawqxy4kgkg+7umpVFIK0EJsk7Es/8Mf5FM0FG/hvdTa70GEK4MP4ohLei/X8hCr+v
 iVZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8664bplx38WHMNoaTs2MRcyyfN9x6BxdX+OC6tRuBrmzB0FyJGkPNWEPEHGlL2XLC4Pw=@dpdk.org
X-Gm-Message-State: AOJu0YwsewQ5y6+DcMr7JTVI/+hd5YrcT0+CddXWjdYMbKIgw8K1WR/l
 eGjw1bvymlO6xjHMNXt0ha5tDzHZAMeI6CM1c0C5MqhgtCui+ylRsPCid1kd1KOG6UAHIZvVCew
 XSBe04gpd0NTlocsnvFdj+cYTGIrlOO7KYTrXfyCsPLVgqvQ8c20qNYMmLcSERDekVGO8ffhnZ/
 JZIwyCmozbDjgEYfg=
X-Gm-Gg: ASbGncvBoF2c1E1+aXkaMCSWfQuSqjRFMKGaCgSzMS8gksGM5p7mPDq/hzVF1R6EAK3
 uFtB3FLOEow3JVDXAFsOTbMJPhBdwSETnEEfLnj5cjXtdlI/WFXu4FmRm1ozNsBf1
X-Received: by 2002:a2e:b241:0:b0:300:3307:389f with SMTP id
 38308e7fff4ca-307c67f5fa1mr11865261fa.0.1738677282728; 
 Tue, 04 Feb 2025 05:54:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRnbXF5a4sVAWT1WOu+BMZtNmq2pYHBgWDMICggwwD+lpXKko2EL4a2emurU4Jj3/6x1WQ7vstzlsauUl0Mb4=
X-Received: by 2002:a2e:b241:0:b0:300:3307:389f with SMTP id
 38308e7fff4ca-307c67f5fa1mr11865221fa.0.1738677282354; Tue, 04 Feb 2025
 05:54:42 -0800 (PST)
MIME-Version: 1.0
References: <PN2P287MB22230CF53B6310DB7F70FF39D3F42@PN2P287MB2223.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <PN2P287MB22230CF53B6310DB7F70FF39D3F42@PN2P287MB2223.INDP287.PROD.OUTLOOK.COM>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 4 Feb 2025 14:54:29 +0100
X-Gm-Features: AWEUYZllQQI9uAEKzJT7BIHE4AzF6a40KJbGkBpBMFUbPqXBGEr6nSRmGwtyAj8
Message-ID: <CAJFAV8z-OCYEY5OYtrxftcLoXeY9HKAZ=T3KuEOu==CreS+Weg@mail.gmail.com>
Subject: Re: Testing dpdk application using openNIC driver
To: Nafiah Siddiqha <nafiah.siddiqha@iwave-global.com>, 
 "Wiles, Keith" <keith.wiles@intel.com>
Cc: "Luca.Vizzarro@arm.com" <Luca.Vizzarro@arm.com>,
 "dev@dpdk.org" <dev@dpdk.org>, 
 "andremue@linux.microsoft.com" <andremue@linux.microsoft.com>, 
 "longli@microsoft.com" <longli@microsoft.com>, 
 Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b47JOQfb67VkwzFZhDuwYDWG4WK1eMW_TXOxvIcJBu8_1738677283
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

Adding pktgen maintainer in the loop.

On Tue, Feb 4, 2025 at 2:42=E2=80=AFPM Nafiah Siddiqha
<nafiah.siddiqha@iwave-global.com> wrote:
>
> Hi,
> I'm testing pktgen application using OpenNIC driver, but I face device ca=
nnot parse issue ,
> What do I need to pass in my vdev parameter for it to run
>
> Below are the logs of the error I'm facing
> $sudo ./usr/local/bin/pktgen --vdev 'eth_af_packet0,iface=3Denp1s0f0' --v=
dev 'eth_af_packet1,iface=3Denp1s0f1'   -l 2-10 -n 4  -- -m [3:4].0 -m [6:7=
].1
> Copyright(c) <2010-2021>, Intel Corporation. All rights reserved. Powered=
 by DPDK
> EAL: Detected 12 lcore(s)
> EAL: Detected 1 NUMA nodes
> EAL: failed to parse device "eth_af_packet0"
> EAL: Unable to parse device 'eth_af_packet0,iface=3Denp1s0f0'
>
>
> I have tried passing eth_pcap, net_pcap and net_af_packet as well but the=
re's no progress in the output.

Some ideas:
The first would be to make sure that the net/af_packet driver is
indeed built into DPDK.
And next one is to make sure that this driver is loaded by pktgen.

The simpler is to check this with testpmd first, and once it works,
look into pktgen (if necessary).

Check if the compiled dpdk (that this pktgen binary is linked to) is
happy with those EAL options (the options between the binary name and
the first -- in the cmdline options).
$ sudo /path/to/dpdk/build/app/dpdk-testpmd --vdev
'eth_af_packet0,iface=3Denp1s0f0' --vdev 'eth_af_packet1,iface=3Denp1s0f1'
  -l 2-10 -n 4  --

If this does not work, look for librte_net_af_packet.so in your dpdk
build directory.
$ find /path/to/dpdk/build/ -name librte_net_af_packet.so

And then pass this directory in the EAL options:
$ sudo /path/to/dpdk/build/app/dpdk-testpmd -d
/path/to/dpdk/build/drivers/ --vdev 'eth_af_packet0,iface=3Denp1s0f0'
--vdev 'eth_af_packet1,iface=3Denp1s0f1'   -l 2-10 -n 4  --


--=20
David Marchand

