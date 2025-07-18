Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E43DC83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 17:00:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F72640DDD;
	Fri, 18 Jul 2025 19:00:37 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id E6EAA40DCA
 for <dev@dpdk.org>; Fri, 18 Jul 2025 19:00:35 +0200 (CEST)
Received: from debian (unknown [78.109.68.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 3A30AE06BE;
 Fri, 18 Jul 2025 21:00:34 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 3A30AE06BE
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1752858034;
 bh=zFk5joLPIDKYGAjzCQYHS5vUMZJ9p8KUsLO8D5PBZi0=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=j3CdUGoWYCdBu22n535d8dlb6qMANuOqo7BEPuXlVGdziGaP9aZ105tVetivZcldb
 l5BOldS3BlDhlhJfssAKq0Vyjq1hSIaEH8JdoORwvq4CgqPIV2GIv1MTHo8KhwOd68
 5Y2/3ibtihDJkITbBYkACS4+Vq33S8eNT/kyfwb0KihXWDEIQ8k7YySiaiactRzKR+
 5iMmYwzPmLfELShnRe3wYg1749gXDZOR8+RUAyM/XbxqREbwrwDN2IlMXThkVxK+E6
 2SCDPwr8EtHFf1lwIBJ3jsQiDrsnx1D4GMc2OIPIUOFajtPDcV1YduzdRigi5ZgjOU
 Q1FBcL6mL50hQ==
Date: Fri, 18 Jul 2025 21:00:32 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Thomas Wilks <thomas.wilks@arm.com>
cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: Re: [RFC PATCH v3 0/2] dts: add RSS functions and test suite
In-Reply-To: <20250718150404.200096-1-thomas.wilks@arm.com>
Message-ID: <0d58b9ac-ad4c-b4f9-159b-47ed9f7f4891@arknetworks.am>
References: <20250225153345.331216-1-thomas.wilks@arm.com>
 <20250718150404.200096-1-thomas.wilks@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-23861484-1752858034=:13106"
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

--8323328-23861484-1752858034=:13106
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi Thomas,

On Fri, 18 Jul 2025, Thomas Wilks wrote:

> Hi all,
>
> This is v3 of the RSS test suites which has been rebased onto the latest patches.
> I’m also requesting comments and some help with an issue where the packet RSS queue and
> the predicted RSS queue differ when running on ConnectX-6 NICs while being the same on E810-C NICs.

Looking at patch [2/2], 'test_key_hash_default_hash_algorithm_queues' might do
the following:

1) insert a flow rule with action 'rss' and a specific/single random queue "A",
    which is expressed as 'rss types ipv4-udp end queues {self.queue} end';
2) set the GLOBAL rss table ('reta') for the port, with the queue indices
    going in some random order (say, [ACBBAAADCDAA..C], of size 512);
3) send/receive the packet;
4) based on the packet mbuf hash value, offset into the GLOBAL table ('reta')
    and retrieve the "expected" queue index;
5) compare the actual receive queue index with the predicted one.

Is this understanding correct?

If my understanding is correct, then I'm afraid this design might be flawed.
Why does it assume the GLOBAL table effect on action 'rss" with some specific
queue index listed in it? In fact, the 'queue' array of the action, at least,
when non-empty, defines exact subset of queues where the packet can land, which
might effectively form a distinct, per-flow 'reta'. In this case, where only one
queue index "A" is specified, the effective 'reta' for this particular flow
match is going to be [AAAAAAAAA..A] (say, of size 512 by default), isn't it?
If so, then why does the code try to peek at the GLOBAL reta instead, when it
has in fact wittingly reduced action 'rss' behaviour to such of action 'queue'?

Once again, I apologise in case I've got something wrong.

> I’m currently in the process of refactoring the test suites and addressing
> the review comments from v2. Below is a summary of the changes made so far that are included in this version:
>

As a separate question, doesn't one also want to verify the "expected" hash
value (SW hash based on the IP/UDP 2/4-tuple) versus the "actual" value?
Or is this too inconvenient to automate in testpmd environment?

Thank you.

> Changes in v3:
> - Merged the RSS test suites into a single file for better maintainability.
> - Moved the supporting functions into the same test suite file and removed the previous separate function file.
> - Combined the reta_key_reta_queues test cases into a single test case.
> - Added new test cases to support flow rule creation on ConnectX-6 NICs.
> - Removed requirements for specific hashing algorithms which has been replaced the flow_validate function.
>
> Regards,
> Thomas Wilks
>
> Alex Chapman (1):
>  dts: add RSS functions to testpmd
>
> Thomas Wilks (1):
>  dts: add PMD RSS testsuite
>
> dts/framework/remote_session/testpmd_shell.py | 132 +++-
> dts/tests/TestSuite_pmd_rss.py                | 610 ++++++++++++++++++
> 2 files changed, 729 insertions(+), 13 deletions(-)
> create mode 100644 dts/tests/TestSuite_pmd_rss.py
>
> -- 
> 2.43.0
>
>
--8323328-23861484-1752858034=:13106--
