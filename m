Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B49FC83F1A
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 08:00:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F4784021E;
	Sun, 20 Jul 2025 10:00:51 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id DE0D6400D7
 for <dev@dpdk.org>; Sun, 20 Jul 2025 10:00:48 +0200 (CEST)
Received: from debian (unknown [78.109.66.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 1321EE0B6A;
 Sun, 20 Jul 2025 12:00:46 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 1321EE0B6A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1752998447;
 bh=PMmR3UyUMW5DAA5QEEn8Dv0vesEjeK0v0DNDrXw6ILo=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=fNVLo19EbnJW6pk8ZDc454n7thLu/PhNSTVV7QTtxDAWJD1WNmQEWmVANKR3dqQKt
 4k4HrqF3yN1e3zbAQ9QlXgKTL5bupO8SppZ+1BCHVJYyUjFaPdfEaVdX8jk2gvlfqu
 FJrjNlaiBSZZDGaYBGWxbV8SLxW8Atn/eW27FtOu3Y/G7Ljdl/04d1xaaLzg4F0H21
 8xa4ndkwC67OoDuVwewN44jAuUN7gDGtLX6mCleCdFGmFDBLnk52Bl2LVjpI9GezFB
 vj/61P9IL04rD6nZH8Oa6Wsx/3qzTNBNJnhpcpeAtVAiHjZWF0vo48TpKKXtutpJFI
 xgWz/dOwv1Cug==
Date: Sun, 20 Jul 2025 12:00:38 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Dean Marx <dmarx@iol.unh.edu>
cc: Thomas Wilks <thomas.wilks@arm.com>, dev@dpdk.org, 
 Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>, 
 Alex Chapman <alex.chapman@arm.com>
Subject: Re: [RFC PATCH v3 2/2] dts: add PMD RSS testsuite
In-Reply-To: <CABD7UXPyhmLKn-v7-8Wp=7fu3cgZSbVhgUzN=xeRNBKZjhh4rA@mail.gmail.com>
Message-ID: <d9e565c4-a5e2-10d7-cbda-067a8dd3a531@arknetworks.am>
References: <20250225153345.331216-1-thomas.wilks@arm.com>
 <20250718150404.200096-1-thomas.wilks@arm.com>
 <20250718150404.200096-3-thomas.wilks@arm.com>
 <CABD7UXPyhmLKn-v7-8Wp=7fu3cgZSbVhgUzN=xeRNBKZjhh4rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1522909303-1752998447=:9884"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1522909303-1752998447=:9884
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi Dean,

On Fri, 18 Jul 2025, Dean Marx wrote:

> On Fri, Jul 18, 2025 at 11:05 AM Thomas Wilks <thomas.wilks@arm.com> wrote:
>>
>> Port over the rss_key_update, pmd_rss_reta and pmd_rss_hash
>> test suites from old DTS into one file including all of the
>> helper functions that are required by all of the test suites
>> to work.
>>
>> The rss_key_update test cases verify that setting a new hash
>> key when Receive Side Scaling (RSS) will result in a change
>> in the packets destination queue. These test cases also
>> verifies that the reported key size of the NIC is correct.
>>
>> The pmd_rss_reta test cases verify that Redirection Tables (RETAs)
>> of different sizes function correctly in RSS. These test cases
>> also verify that the reported reta size of the NIC is correct.
>>
>> The pmd_rss_hash test cases verify that the 4 supported types of
>> hashing algorithm used in RSS function correctly and that the nic
>> supports them. The four hashing algorithms being DEFAULT, TOEPLITZ,
>> SYMMETRIC_TOEPLITZ and SIMPLE_XOR. These test cases also verify
>> that the supported hashing algorithms reported by the NIC are correct.
>>
>> Signed-off-by: Alex Chapman <alex.chapman@arm.com>
>> Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
>
> It was brought up at the DTS meeting yesterday that this suite is
> reliable on Intel NICs, but unreliable on Mellanox (CX6), which I can
> confirm after running on a CX5 and Intel XL710 and seeing the same
> behavior.

As I tried to explain earlier, this might be due to the 'queue' array of the
action 'rss' logically comprising a separate 'reta' for the packets intercepted
by the flow. The test should not check such packets against the global 'reta'.

As to why the test passes for the latter NIC, please take a look at [1]. In that
specific case, the code that is meant to parse the 'queue' array of action 'rss'
might be called only when there are no match items in the flow pattern or when
the first pattern item is VLAN. If this is indeed the case, then the use of
action 'rss' overrides only the hash types for packets intercepted by the flow,
but not the 'reta' to be used, so they still land the global 'reta'.

Also, in 'setup_rss_environment', it might be more robust to first configure the
port's global 'reta' and then insert the flow (if any), to rule out the flow
possibly overriding the global 'reta', which, in theory, shall not happen.

With this in mind, the test could possibly be reworked to act as follows:

1) set up and memorise the port's global 'reta';
2) create a flow rule (say, match UDP DST "A") with 'rss', memorise its 'reta';
4) send a packet that matches the flow (say, with UDP DST "A");
5) receive the packet and check the queue against the flow's own 'reta';
    on queue mismatch, check against the global 'reta' and log the artifact;
6) send a packet that does not match the flow (say, with UDP DST "B");
7) receive the packet and check the queue against the global 'reta'.

[1] https://github.com/DPDK/dpdk/blob/f6e3473724e7ce31103fa0ecad62b282ec8e7090/drivers/net/intel/i40e/i40e_hash.c#L1176

Thank you.

>
> Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
> Tested-by: Dean Marx <dmarx@iol.unh.edu>
>
--8323328-1522909303-1752998447=:9884--
