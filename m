Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B87F364CA
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 22:11:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30ABD402A2;
	Fri, 10 Apr 2026 00:11:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 84C664028D
 for <dev@dpdk.org>; Fri, 10 Apr 2026 00:11:12 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2E101F02;
 Thu,  9 Apr 2026 15:11:05 -0700 (PDT)
Received: from [10.118.105.34] (u104515.arm.com [10.118.105.34])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38AEA3FAF5;
 Thu,  9 Apr 2026 15:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775772671; bh=hMs4u4c77fhpGv1d0ELnp5+hF6ePTG5HXBxpHmxH94g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QNvIn+rolVUrqmy/VtFhO0dYzCSTIA6hH+GNjs+PMgkR83y6n+zrX2r+s3h/swDwn
 BNiDu/qkwKc+uB02Ld07pWWOSfEdfUYL/FVOnPv081hlIzeCn78uKmVr821KCmjFuq
 Y4XI/ZBp5X/LQ4o+MMhMDzp84lH0VOZc19JmIINA=
Message-ID: <35f96fed-29d4-4a0b-b3a1-0f2c9fc6b60e@arm.com>
Date: Thu, 9 Apr 2026 17:11:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] bpf/arm64: support packet data load instructions
To: Christophe Fontaine <cfontain@redhat.com>, dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
References: <20260310122045.4057836-1-cfontain@redhat.com>
 <20260319114500.9757-1-cfontain@redhat.com>
 <20260319114500.9757-3-cfontain@redhat.com>
 <CAHVr2N=DR9G8Wixv9sgov9Ks_DZkxbRHovn4ng0uME6GX8RboA@mail.gmail.com>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <CAHVr2N=DR9G8Wixv9sgov9Ks_DZkxbRHovn4ng0uME6GX8RboA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Christophe,

Thanks for doing this work. I saw that you intend to submit a v3 due to 
failure in Ubuntu. Please, see my comment regarding emit_b below.

>> +       /* A64_R(0) = mbuf->buf_addr */
>> +       emit_mov_imm(ctx, 1, tmp1, offsetof(struct rte_mbuf, buf_addr));
>> +       emit_ldr(ctx, EBPF_DW, A64_R(0), r6, tmp1);
>> +       /* tmp2 = * mbuf->data_off */
>> +       emit_mov_imm(ctx, 1, tmp2, offsetof(struct rte_mbuf, data_off));
>> +       emit_ldr(ctx, BPF_H, tmp2, r6, tmp2);
>> +
>> +       /* A64_R(0) += data_off + off */
>> +       emit_add(ctx, 1, A64_R(0), tmp2);
>> +       emit_add(ctx, 1, A64_R(0), A64_R(1));
>> +
>> +       /* End of Fast Path, skip slow path */
>> +       emit_b(ctx, 4);
>> +
Followed by emit_b() above there is an emit_call(). It invokes 
emit_mov_imm() which could possibly generate different number of movk 
instructions depending on the address of the __rte_pktmbuf_read. So, 
emit_b(ctx, 4), may not  necessarily land at the intended location 
because there could be more than 4 instructions emitted by emit_call.
>> +       /* slow path, call __rte_pktmbuf_read */
>> +       emit_call(ctx, tmp1, __rte_pktmbuf_read);
>> +       /* check return value of __rte_pktmbuf_read */
>> +       emit_return_zero_if_src_zero(ctx, 1, A64_R(0));
>> +
>> +       /* A64_R(0) points to the data, load 1/2/4 bytes into r0*/
>> +       emit_ldr(ctx, opsz, r0, A64_R(0), A64_ZR);
>> +       if (sz != sizeof(uint8_t))
>> +               emit_be(ctx, r0, sz * CHAR_BIT);
>> +}
>> +
>>   

--wathsala


