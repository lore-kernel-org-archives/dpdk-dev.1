Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3FBC5DF66
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 22:33:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B439140294;
	Mon, 17 Aug 2026 00:33:47 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id BDCF84027A
 for <dev@dpdk.org>; Mon, 17 Aug 2026 00:33:46 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so3308186a91.3
 for <dev@dpdk.org>; Sun, 16 Aug 2026 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786919626;
 x=1787524426; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8GWXaBw0dpOUHhuWSp5jeGbzMHZWt1v8ONMTkRoiea4=;
 b=ZTc6gjoqpdAVDVYHDoMOOasuPNmcVKX9VipoqHW1TL/9miDOrCKpwrNnnqm0NmGxVY
 AL8uI6fOJgYg3TkGzNbUw4pIwQl0wEIKZnwh7pWKkro2psuLSoijlW04vlMep+2lq+Dk
 2VBlBoIcUF8/alv+Wz3RGa3rkTjLHUqIPYn90ddYLZbxvZRoDeV39gPQxy+P3wjO4QkU
 7o2w8aKcj9UOQmUyhxE0cPmAfsg5QB6yHSOZjVJ5AE8EKBTPqVTkQoMt64srU5p83f0k
 bNAdRGrHGThZXXCwJeWC4nB1Xcc3uU5Mxq88eA4JJ/nf2xweL6fGdjZhZjvxVa6Klo2f
 5v3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786919626; x=1787524426;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8GWXaBw0dpOUHhuWSp5jeGbzMHZWt1v8ONMTkRoiea4=;
 b=KN/mRK8gX9ppx75etkru5gTCr2xdI0VDEI75ly0F8McuZ3m32Ya7HyYnhEQ0cE+Czg
 kikjDKpsqKLPfpDXRGJQ++Mx3O909j81e7+2h9oHVI65WvUjM0/Y/b6pJramCPsGtWeK
 WYSaoGCweFwUJZWqYQVF46eFv36Gzp6m2DPLD3i6WT0uE46DFhRph/H90TtHIYMzB8Qy
 bgYgnICdyGhs5qHPBJlY1tpf24KoCN9Bel0KY/k9ubiAMHCvK2vhdp28uiHIfHas6uVE
 uY26zmfaPV7VBE2+LDEAEnID8cMn8SuSKXMVzvlbX6eygPutY/ilnWC+UN+jyRtzvtYi
 ktaA==
X-Gm-Message-State: AOJu0Yxxtn+o9ruuneUDIQ1e//t4x+AYpuQXxCk+URXPH7nc/Kpja+aE
 Qs/nOe2RSO6zKM+DIbG/dETZL1g24fcM6S9JHcQ81cDRIzifLYcAzrbI6Y1Fo0N/l5Y=
X-Gm-Gg: AR+sD12ic3xoiCJTao+Tx0e2nbfjf2vdo+J4amCihe69jto6+M1DEVhDPY7jOLdgSKY
 SY/EHpNAFgQ1Ya/4jXKZFjxQc50VYCOd6gYBryCqWUlfAFJngjAT9eur8ihoefLYTCas4BKg/oA
 0F5h9HJbOcRcq36CCGc/2/mz07dtzHUPci8NNEPtL+EWRtuxD9GB7gY8j4fWbHsqwXTJAJVEo8K
 ThSduP1+OR9rmy3QYDsZzx9N2YVjWlyD8YGfH49NFODOATnSnizv/EBAjzg3F9Vht6zm1dkwNpd
 6wAQ9at2/19Bn9P4qw5pGSf+7ysdXacwPfLu9yPGYdqzpM8rkcgv+Cae/IyTXVFdBJ0JGcXEF8p
 22JYBf0WIV+JczBHdkjTN+K8A6SLAGSzls2VmcSLeBbaqPJ0oVB1lpa4ebwLN3qg4mO1naWt1mX
 G/V764NrskQ3xwP6rsBy28ELkJgjWwJSNdxuYV+hiYZC1f6XwfBsPqG/SWVG0S2EtUVpDjdkqhx
 s3w2i5EAWfIAPyeF1oLFM8whWBUQ+YYPJEx6ls/
X-Received: by 2002:a05:6a21:1786:b0:3c8:e140:63c3 with SMTP id
 adf61e73a8af0-3cc720d1fc3mr24956034637.37.1786919625744; 
 Sun, 16 Aug 2026 15:33:45 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141387ed5b1sm57200559c88.8.2026.08.16.15.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 15:33:45 -0700 (PDT)
Date: Sun, 16 Aug 2026 15:33:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: dev@dpdk.org, Praveen Shetty <praveen.shetty@intel.com>
Subject: Re: [PATCH 2/2] net/cpfl: validate fieldvector offsets before
 copying keys
Message-ID: <20260816153337.1e078d8d@phoenix.local>
In-Reply-To: <20260321021634.96514-1-pengpeng@iscas.ac.cn>
References: <20260321021634.96514-1-pengpeng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sat, 21 Mar 2026 10:16:34 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> The CPFL JSON parser accepts fieldvector offsets and SEM key sizes straight from the input description. Reject offsets that would write past the 64-byte SEM fieldvector storage and reject key sizes that would later overread the fixed source buffer or overflow the destination key buffer.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---

This patch does not build which makes it a complete NAK.

Also, lots of AI reported issues.


Patch 2/2: net/cpfl: validate fieldvector offsets

Error: does not compile

  In cpfl_flow_js_pattern_per_act():

	if (js_act->sem.keysize > sizeof(js_act->sem.cpfl_flow_pr_fv)) {

  js_act is struct cpfl_flow_js_pr_action *, so js_act->sem is
  struct cpfl_flow_js_pr_action_sem, whose members are prof,
  subprof, keysize, fv and fv_size.  There is no cpfl_flow_pr_fv
  member.  That name belongs to struct cpfl_flow_pr_action_sem, a
  different type (cpfl_flow_parser.h:236-241).  The JSON spec
  structure and the runtime action structure have been confused.
  The intended bound is CPFL_JS_SEM_FV_KEY_NUM_MAX.

Error: the fv_proto offset check bounds the wrong value and is
       discarded

  The check added to cpfl_flow_js_pattern_act_fv_proto() applies to
  the offset stored in js_fv->proto.offset.  That is a byte offset
  into the matched rte_flow item's spec buffer, consumed in
  cpfl_parse_fv_protocol() as

	pointer = &(((const uint8_t *)(items[j].spec))[v_offset]);

  It is not a field-vector index, so bounding it by
  CPFL_JS_SEM_FV_KEY_NUM_MAX / 2 rejects legitimate protocol
  offsets while preventing no overflow.

  It also has no effect at all: both callers ignore the return
  value.

	cpfl_flow_js_pattern_act_fv_proto(ob_value, js_fv);
	cpfl_flow_js_pattern_act_fv_proto(cjson_value, js_fv);

  in cpfl_flow_js_pattern_act_fv() and
  cpfl_flow_js_pattern_act_fv_lem().  The same is true of
  cpfl_flow_js_pattern_act_fv_metadata().  Those unchecked returns
  are a pre-existing bug worth fixing, but they mean this hunk is
  dead code as written.

  The check added in cpfl_flow_js_pattern_act_fv() is the correct
  one: js_fv->offset is what indexes fv[2 * offset] and
  fv[2 * offset + 1] in cpfl_parse_fieldvectors(), and the SEM
  vector is CPFL_JS_SEM_FV_KEY_NUM_MAX (64) bytes, so offset < 32
  is right.

Error: the LEM path has the identical bugs and is left unfixed

  cpfl_flow_js_pattern_act_fv_lem() reads js_fv->offset with no
  bound.  cpfl_parse_fieldvectors() writes fv[2 * offset] and
  fv[2 * offset + 1] into pr_action->lem.cpfl_flow_pr_fv, which is
  CPFL_JS_LEM_FV_KEY_NUM_MAX (32) bytes, so the LEM bound is
  offset < 16, not 32.

  cpfl_fxp_parse_pattern() likewise guards only the SEM branch:

	memcpy(rinfo->lem.key, pr_action->lem.cpfl_flow_pr_fv,
	       rinfo->lem.key_byte_len);

  key_byte_len comes from the unvalidated uint16_t lem.keysize, the
  source is 32 bytes and rinfo->lem.key is 128, so this both
  overreads the source by up to ~64 KB and overflows the
  destination.  That is the same bug the patch fixes for SEM.

Info: second condition in the SEM check is unreachable

	if (pr_action->sem.keysize > sizeof(pr_action->sem.cpfl_flow_pr_fv) ||
	    pr_action->sem.keysize > sizeof(rinfo->sem.key)) {

  cpfl_flow_pr_fv is 64 bytes, rinfo->sem.key is
  MEV_SEM_RULE_KEY_SIZE (128).  The first condition always fires
  first; the second can be dropped.

Warning: missing Fixes: and Cc: stable@dpdk.org

  Fixes: 41f20298ee8c ("net/cpfl: parse flow offloading hint from JSON")
