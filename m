Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B99C19776
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 09:01:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 207E040609;
	Fri, 28 Feb 2025 10:01:42 +0100 (CET)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 7DD904028C
 for <dev@dpdk.org>; Fri, 28 Feb 2025 10:01:40 +0100 (CET)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 1A9BB16D8
 for <dev@dpdk.org>; Fri, 28 Feb 2025 10:01:40 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 0E9CC16D7; Fri, 28 Feb 2025 10:01:40 +0100 (CET)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id AE89A1702;
 Fri, 28 Feb 2025 10:01:38 +0100 (CET)
Message-ID: <a3f7283e-6a3d-42ce-abf1-cd5101593a3e@lysator.liu.se>
Date: Fri, 28 Feb 2025 10:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "dev@dpdk.org" <dev@dpdk.org>
Cc: =?UTF-8?B?U3ZhbnRlIErDpHJ2c3Ryw6V0?= <svante.jarvstrat@ericsson.com>
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
Subject: DPDK trace "by reference"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

Hi.

At the point of a DPDK app crash, or some other abnormal event, you may 
want to save the trace buffer, especially if a complete core file is too 
large to fit on the disk.

This would be straight-forward to implement on top of DPDK trace.

However, you may also want to save data which is referred to 
by-reference in the traces, like for example mbuf pointers. The reason 
for not have the data by-value may be that it would be too expensive for 
always-on type trace points.

How could one go about solving the latter case with DPDK trace?

Decoding CTF and de-referencing the appropriate data (e.g., in the 
signal handler) seems technically possible, but very complicated without 
"framework" (i.e., DPDK trace) support. Then you would also need to 
regenerate CTF (including new meta data), but now with the by-reference 
fields as by-value fields.

Ideally, as far as I see, one would like the app to mark a certain field 
as a pointer to X bytes of data, which could potentially be dereferenced 
at a point of a crash.

Obviously, mbufs can be recycled and other buffers may change state 
compared to what they were during at the time of the trace entry being 
created. Nevertheless, such data, although inaccurate/best effort, may 
be worth a lot in a postmortem debugging scenario.

You could have something on the side of DPDK trace, which maintained the 
buffers and pointers and could be dereferenced/copied around at the 
point of the "abnormal event", but I'm curious if there is a solution 
where you rely fully on an extended version of DPDK tracing.

/M
