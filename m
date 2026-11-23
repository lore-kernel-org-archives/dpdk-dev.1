Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E9606A332
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gqwCXGdC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBD65402CC;
	Mon, 23 Nov 2026 19:38:30 +0100 (CET)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 4458D402CC
 for <dev@dpdk.org>; Mon, 23 Nov 2026 19:38:29 +0100 (CET)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8b271e573adso1528192b3a.2
 for <dev@dpdk.org>; Mon, 23 Nov 2026 10:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795459107;
 x=1796063907; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hUsemNP72/VLsyvbFpuLu4ow/AIDS2NS5dVOZoWDskM=;
 b=gqwCXGdCTw6hc9KpPIKA8nw797HbKivesrX6ZMo/A/iNYO7zgPHcTyYPV3/dJmUTc/
 3KtCob6iK+QtH8z6wXAxNlc0cYZJzG10Yt555a2G7tDjFnx6F18hskkeMmpJt/AU0s38
 RTCtXwW4MSI2TUk0R2ZWCFVDFmBqP0gBIDOxfHEluwVT/i9JPHO9sfjtYYPGdHuIFfwm
 F3FJxtZ43v36l6GWUBU6tUKbQgRjTodb11TeSARZbThq9crn7JaUHcPLeHuBLrB7enGQ
 NnDPR4m5ezZZfMqXki8gafnajQHMQHIfXuwi46KCS/g+pFUk7KM2p6tX+N0zmEt4axIu
 g14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459107; x=1796063907;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hUsemNP72/VLsyvbFpuLu4ow/AIDS2NS5dVOZoWDskM=;
 b=kD6owudwTm1rSU8ZIN4pqCPHUP+Wyt7MmirGEk86oPXAlhJXCdULjg8K8tYgvICW0w
 kSpRH3ZA6vRMLguiM9jugYcbZGtGczR8yYkXR+nr3eAVKB1hB2uBcoeO73OP3B8B17Ei
 4y/RH3myKgLDIxewAjwRFABasnVI91LvBhHbaw74kTRbWOfcBzacFaOVyhVVOgJQ6j+1
 tkv70PVlQfP4fip9Fu7TBGcI1ti/ZqDt60GX5iZfgEvjjvP8JXCoug+oiVflxeTfwDz0
 HHcUOFTXso9rf+GtI3kdkTS7VJqJKTcd7ZBIERwDfD5Z3Ri1uu6GN5xyNS0GWt6rbm11
 6A3A==
X-Gm-Message-State: APuU4Z8pi0cGkPJJPF35yrdhYTqV307sY4i0mEZnn3W32rke3bM1M6IU
 WAGMxMBgdahzt5Zck6OBcggMY5g+PMaUliZK1XBKYNS1bKOfcfYpcErHVjnZOINznQo=
X-Gm-Gg: AZFdTZc2S0CFMxfdDGgpuX0bcjRfj/tZOCI777eljnkbTg0D588bh4sGTB0MhzDsU1z
 lzRkz9IFySg/Hr6T69x7svOSiVX0iCfUcYEH4w7XdQCRprr1UbtEA6KJznvvToSdKV0fK8iPaRW
 V19l28p2XDDVovtXKw8vnFwRR9dIH+9n7QqdwAmOpoNBhhvCWZ+1+/keUCJF7SUmKmMe+w0y7di
 S1Up4nlYtO3uZFbwxg5qN6rYl9BD9Chb7/Z3XS1lRrL5SWP04Fl34zIU1I81opcz61FPYUr28kL
 0n0yJVMC8PICed2pm2SSb9xMKv22NmJrjPNz9/VOuBt309SBLZeG+XVdHdw8rSri2RL57IoBHZy
 Yw18wpdPm7b0qwsZ4swnVF5yRuwVaVRhU3tEumw6IoXnyn06Iufex/CxgfKlC4u8WL6vIJr3c/1
 HrquPDdjajlraKVYvLFMqC6yUxtsf0ftJ4BGCa+wYwSIbUaEA7W+TgteKWR7zQQ897tIZym8oGH
 +cygO2s5rgVSTMyMdd4MfOjtHCYEGavhWyhShlNXALRKcJUOW8EGt/HJccaMHSi/9FNehn4JlLU
 8MmsKektX+yx7c/XmfkMUyQLTqYkooHqf/dT87XWOFJXFzNARRiOwYYqpf3K2tYTo1/7aBk=
X-Received: by 2002:a17:90b:4c12:b0:3b0:a831:5acc with SMTP id
 98e67ed59e1d1-3b41c95408emr11767429a91.42.1795459103263; 
 Mon, 23 Nov 2026 10:38:23 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41aab4729sm18861516a91.0.2026.11.23.10.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:38:23 -0800 (PST)
Date: Mon, 23 Nov 2026 10:38:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2] app/testpmd: use burst IO for IEEE1588 forwarding
Message-ID: <20261123103820.0862e604@phoenix.local>
In-Reply-To: <awRvkp9PqarVGrqF@bricha3-mobl1.ger.corp.intel.com>
References: <20261118151155.2740034-1-bruce.richardson@intel.com>
 <20261123122626.2253504-1-bruce.richardson@intel.com>
 <20261123085050.75d472c2@phoenix.local>
 <awRvkp9PqarVGrqF@bricha3-mobl1.ger.corp.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 16:53:38 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> > Since only called here:  
> > >  static bool
> > > -ieee1588_packet_fwd(struct fwd_stream *fs)
> > > +ieee1588_process_packet(struct fwd_stream *fs, struct rte_mbuf *mb)
> > >  {  
> > 
> > Make it void not bool
> > 
> > and drop the cast.
> >   
> 
> I thought about that, and thought it best to leave it as bool to allow for
> any future error checking we might need. The cast can be safely dropped,
> but I think some form of return value might be useful from this.

YAGNI

Since it is internal to the file, you can change API at will later
to return an int or whatever suits.
