Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BEAC44501
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Jul 2026 12:37:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D60A4027A;
	Sat, 11 Jul 2026 14:37:14 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 309574026F
 for <dev@dpdk.org>; Sat, 11 Jul 2026 14:37:13 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 88878EC00C9;
 Sat, 11 Jul 2026 08:37:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Sat, 11 Jul 2026 08:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783773432;
 x=1783859832; bh=hSt5jhSYv/tvBQ890xCWklh32xu5yTs0r7KDn+tqSLk=; b=
 NcV12vAG9Oxi3iAyOLtx75yQpXQFLZO3ydXtwPKGzjMLjPLAuGFlxwrnRjnTq9+9
 mw1VOrXCvjRcVKx3ICjoWRbHtSs/sMgc2olZuci77Tv3no6IkNru0y3W+EDOFx2i
 dyvMiRfnCydDUd8DIeW7b/6cKCBEAow0jbGf/xFfZfefjRGbsCBSphDxCplH+JTq
 ZJWvxz+vSZDN0D1XLbf1dQFt0SaD+oVyTzl53I1OaieOEEpqib7N8+WGQKBVTjIt
 PKfCzF/Asf533FGZ87UbFUe97f75KAevYfdAPpTqCi0pscEzvQfYBT4+piJCMf1y
 N/UrS0lwX/Om/MlddTecLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783773432; x=
 1783859832; bh=hSt5jhSYv/tvBQ890xCWklh32xu5yTs0r7KDn+tqSLk=; b=W
 7snGCB1/dqZj6OA5nHz5oiS/qM73hpVtglLTcbDBhiS48VG/ppr9cMmDNti5o6Ir
 5fAV/3oYPduC9kYWi8vzgJuQ3m3blfd1TUdx6oTh5Bh+MXXYAkveP9fqEzegMDdg
 TzyLWCh5ryXW5pDAlkZ3Hiznx06/YOVO9ynijht4YJFH7b1paMiOrOg+zmJMuKd1
 PYskBPGIFqn/ov3cMrA6hENwndKUYXLvni/DNsdZT5r+hJIqUgq6AEFCqHg/3uc3
 heEWq6NdUmPv5kydJ5mPMqYVGXfI9QDgxPYhC4K8XXihX27MqRU9sZDSp+ioRerA
 iNP3db0SvgTx/VRq7HB9A==
X-ME-Sender: <xms:9zhSau-YPCsD-WxS2PEbOOun8I7VFs4E1KvrjO5yNfANcPtvhNkhgw>
 <xme:9zhSau1YGSOTKVn8r4S5ZkUggkMwICjGAMi1l__2JwRFUQ1JKhFAVH8HKeFO-pVlS
 jIQt9Kr0IWDtMfRZJyaJSJDSPSJAeNx1dOJW4Gh-iFoeLa3dEoIRA>
X-ME-Received: <xmr:9zhSar_U_qVPZxtDl2iXs5ACqMzeIHh05zetRrzQ7-t2SBPazDuNtR5FfR4Jfu_0I9XZfT3O2fmNdpr3GA>
X-ME-Proxy-Cause: dmFkZTFngBzDoHSUxhRS8jcOqd4nHarerHmm+C4gUXI5VSu9p1LPuU7yFa+NQNl4EocAHX
 wiWeSeRifucy8XZfPx2zQSxIgqoOR+KGA2wth9My6UtVQMs6dfGu3opsNwG5PJqd3i4c00
 dPEJW2bRxXuvFPpqgqZucnmFIECcdFvJIdpPZnrcBtwP2LN0RRZO2kXxvvYtaZPcgVYSAH
 ZQTw/UK9BQ+l3J2QfS3ZEnJFTOIH+8dbEXCWr8rewp0SL45xJ7Kr/BSBqr6WDB6i6UXvk+
 ItHD46anoS23BdOnHK2cl5MdzG21HMnL7oj3YNXrCfYNviMsvQ+8TsVDuIR5A3GvHubFb1
 l7pj6JaDdgrFsJ5VfYHU/DSh2lhJroR6dpOUuMI2VafE4VYQUMj27TwcnOq/9lQp4fSuYm
 iwjdPEQeL70qwczoqmWURsl0Hvxey5HErXaYT9A0bDcCddFlum3+6ysUmhW+5Owef9wiIJ
 1J0KOWCxglmD8NII9vytK4QMNPsUnh4PLX1eEvj8KsqKUGv19q3tKjFFpwXrbXbZN1baYr
 GzQEf4f+LSunN3FwtvIN+9HvS98CC9SQX6rs9YIrGFdarNYUeWOVhM6gRIPQ/yyYClM9NL
 +7Awu2vh+UvgrcXWqHFeJghlgSON9336VhCZNBIJLNnlA0XkgUtFN7bLk1/w
X-ME-Proxy: <xmx:9zhSauvv5sV9gJmmC8bDw-J1Hg7sldl0bnjMssuIDiscuZSmixia-Q>
 <xmx:9zhSauBWbyOVTXg04crTN6QEsNPDSek-If3F6wSF5wXBobWDA9oe9w>
 <xmx:9zhSamVLFU51z8hXNF_uA1XAUcjNONkKC5ER5Bdk1nNb_WPDqTO7sg>
 <xmx:9zhSasANKyWtltIpKvjdEbJ22WWUxRos8V9BHfbrtN5ZafDODRk1VQ>
 <xmx:-DhSalmTi1wVrRzM7rK9UIb4cOQUseF5X9nNTn59D0aOr_nD6RhePt4u>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 08:37:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 2/2] bpf: silence noisy message
Date: Sat, 11 Jul 2026 14:37:07 +0200
Message-ID: <fE30tZ4lSfq0qxkAArwu9w@monjalon.net>
In-Reply-To: <5745cb1553bb4e0e870d36e36755187e@huawei.com>
References: <20260701223453.104660-1-stephen@networkplumber.org>
 <20260702093004.15841f2b@phoenix.local>
 <5745cb1553bb4e0e870d36e36755187e@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

02/07/2026 18:34, Marat Khalili:
> > https://github.com/DPDK/dpdk/blob/09e4f37ddd0f7d5cc7c696741f31f1582c73a716/lib/bpf/bpf_load_elf.c#L331
> > -L333
> > >
> > > (In fact I tried to eliminate it, but had to but back at the insistence of AI reviewer
> > > and even broke the build in the process...)
> > >
> > > So naturally I support downgrading this message. With the commit message corrected,
> > >
> > > Acked-by: Marat Khalili <marat.khalili@huawei.com>
> > 
> > Looks like you added that message in:
> >   55192fe168b9 ("bpf: introduce extensible load API")
> 
> It was moved from a different file, see above.
> Maybe it applied to fewer code paths since they are now all merged.
> 
> Anyway it's not really important unless you think it's worth backporting.
> Feel free to downgrade or remove this message.

Fixes: 5dba93ae5f2d ("bpf: add ability to load eBPF program from ELF object file")
Cc: stable@dpdk.org


